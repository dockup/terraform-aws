#
# EKS Cluster Resources
#  * IAM Role to allow EKS service to manage other AWS services
#  * EC2 Security Group to allow networking traffic with EKS cluster
#  * EKS Cluster
#

resource "aws_iam_role" "eks-cluster" {
  name = "tf-${var.cluster_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = "${aws_iam_role.eks-cluster.name}"
}

resource "aws_iam_role_policy_attachment" "eks-cluster-AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = "${aws_iam_role.eks-cluster.name}"
}

resource "aws_security_group" "eks-cluster" {
  name        = "tf-${var.cluster_name}"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${aws_vpc.eks-cluster.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "tf-${var.cluster_name}"
  }
}

resource "aws_security_group_rule" "eks-cluster-ingress-nodes-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.eks-cluster.id}"
  source_security_group_id = "${aws_security_group.eks-nodes.id}"
  to_port                  = 443
  type                     = "ingress"
}

resource "aws_eks_cluster" "dockup" {
  name     = "${var.cluster_name}"
  role_arn = "${aws_iam_role.eks-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.eks-cluster.id}"]
    subnet_ids         = "${aws_subnet.eks-cluster[*].id}"
  }

  depends_on = [
    "aws_iam_role_policy_attachment.eks-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.eks-cluster-AmazonEKSServicePolicy",
  ]
}

data "aws_eks_cluster_auth" "dockup" {
  name = "${aws_eks_cluster.dockup.name}"
}

resource "kubernetes_config_map" "eks-nodes" {
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
  }

  # Generated mapRoles using https://github.com/sl1pm4t/k2tf
  data = {
    mapRoles = "- rolearn: ${aws_iam_role.eks-nodes.arn}\n  username: system:node:{{EC2PrivateDNSName}}\n  groups:\n    - system:bootstrappers\n    - system:nodes\n"

    mapUsers = yamlencode([
      for admin_arn in var.cluster_admins_arns : {
        userarn = admin_arn
        username = element(split("/", admin_arn), 1) # 0 indexed
        groups = ["system:masters"]
      }
    ])
  }

  depends_on = [aws_autoscaling_group.eks-nodes]
}

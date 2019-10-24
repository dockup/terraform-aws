#
# Outputs
#

locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.dockup.endpoint}
    certificate-authority-data: ${aws_eks_cluster.dockup.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}

output "cluster_name" {
  value = "${aws_eks_cluster.dockup.name}"
}

output "cluster_region" {
  value = "${data.aws_region.current.name}"
}

output "cluster_host" {
  value = "${aws_eks_cluster.dockup.endpoint}"
}

output "cluster_cert" {
  value = "${base64decode(aws_eks_cluster.dockup.certificate_authority.0.data)}"
}

output "cluster_token" {
  value = "${data.aws_eks_cluster_auth.dockup.token}"
}

output "persistence_ids" {
  value = "${aws_ebs_volume.persistence[*].id}"
}

#
# EKS Cluster autoscaling of nodes
#  * Following https://docs.getdockup.com/how-tos/aws-eks-auto-scaling-instructions
#  * Installs helm chart for cluster-autoscaler
#

resource "helm_release" "cluster-autoscaler" {
  name = "dockup-autoscaler"
  chart = "stable/cluster-autoscaler"
  version = "0.13.3"

  set {
    name = "autoDiscovery.clusterName"
    value = "${aws_eks_cluster.dockup.name}"
  }

  set {
    name = "awsRegion"
    value = "${data.aws_region.current.name}"
  }

  set {
    name = "sslCertPath"
    value = "/etc/kubernetes/pki/ca.crt"
  }

  set {
    name = "rbac.create"
    value= "true"
  }

  timeout = 300
}

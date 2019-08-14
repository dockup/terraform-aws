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
    value = "${var.cluster_name}"
  }

  set {
    name = "awsRegion"
    value = "${var.cluster_region}"
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
  depends_on = [kubernetes_cluster_role_binding.tiller-cluster-admin]
}

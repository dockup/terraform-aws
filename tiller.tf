#
# Helm setup so that everything can be listed
#  * Following https://docs.getdockup.com/how-tos/aws-eks-auto-scaling-instructions
#  * Installs helm chart for cluster-autoscaler
#

resource "kubernetes_service_account" "tiller" {
  metadata {
    name = "tiller"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role_binding" "tiller-cluster-admin" {
  metadata {
    name = "tiller-cluster-admin-rule"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "tiller"
    namespace = "kube-system"
  }
}

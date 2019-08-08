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

resource "kubernetes_deployment" "tiller" {
  metadata {
    name = "tiller-deploy"
    namespace = "kube-system"

    labels = {
      app = "helm"
      name = "tiller"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "helm"
        name = "tiller"
      }
    }

    template {
      metadata {
        labels = {
          app = "helm"
          name = "tiller"
        }
      }

      spec {
        container {
          image = "gcr.io/kubernetes-helm/tiller:v2.14.1"
          name = "tiller"

          env {
            name = "TILLER_NAMESPACE"
            value = "kube-system"
          }

          env {
            name = "TILLER_HISTORY_MAX"
            value = "0"
          }

          port {
            name = "tiller"
            container_port = "44134"
          }

          port {
            name = "http"
            container_port = "44135"
          }
        }

        automount_service_account_token = true
        service_account_name = "tiller"
      }
    }
  }
}


resource "kubernetes_service" "tiller" {
  metadata {
    name = "tiller-deploy"
    namespace = "kube-system"

    labels = {
      app = "helm"
      name = "tiller"
    }
  }

  spec {
    selector = {
      app = "helm"
      name = "tiller"
    }

    port {
      name = "tiller"
      port = 44134
      target_port = "tiller"
    }
  }
}

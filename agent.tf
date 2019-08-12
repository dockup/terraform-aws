#
# Helm setup to get agent up and running!
#  * Following https://docs.getdockup.com/how-tos/set-up-dockup-agent-on-aws
#  * Installs helm chart for traefik, and dockup agent
#

data "helm_repository" "dockup" {
    name = "dockup"
    url  = "https://helm-charts.getdockup.com"
}


resource "helm_release" "dockup-agent" {
  name = "dockup-agent"
  chart = "dockup/agent"

  set {
    name = "agent.dockupApiKey"
    value = "${var.agent-key}"
  }

  timeout = 300
  depends_on = [kubernetes_service_account.tiller]
}


resource "helm_release" "traefik" {
  name = "traefik"
  chart = "stable/traefik"

  set {
    name = "rbac.enabled"
    value = "true"
  }

  timeout = 300
  depends_on = [kubernetes_service_account.tiller]
}

#
# Helm setup to get agent up and running!
#  * Following https://docs.getdockup.com/how-tos/set-up-dockup-agent-on-aws
#  * Installs helm chart for dockup agent
#

data "helm_repository" "dockup" {
    name = "dockup"
    url  = "https://helm-charts.getdockup.com"
}


resource "helm_release" "dockup-agent" {
  name = "dockup-agent"
  chart = "dockup/agent"
  version = "0.3.1"

  set {
    name = "agent.dockupApiKey"
    value = "${var.agent_key}"
  }

  timeout = 300
  depends_on = [kubernetes_cluster_role_binding.tiller-cluster-admin]
}

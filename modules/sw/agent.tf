#
# Helm setup to get agent up and running!
#  * Following https://docs.getdockup.com/how-tos/set-up-dockup-agent-on-aws
#  * Installs helm chart for dockup agent
#

resource "helm_release" "dockup-agent" {
  name = "dockup-agent"
  repository = "https://helm-charts.getdockup.com"
  chart = "agent"
  version = "0.4.4"

  set {
    name = "agent.dockupApiKey"
    value = var.agent_key
  }

  set {
    name = "image.tag"
    value = var.agent_image_tag
  }

  set {
    name = "agent.dockupHost"
    value = var.agent_dockup_host
  }

  set {
    name = "secrets.pullSecretBase64"
    value = var.agent_pull_secret_base64
  }

  set {
    name = "timberSourceId"
    value = var.agent_timber_source_id
  }

  set {
    name = "timberApiKey"
    value = var.agent_timber_api_key
  }

  timeout = 300
  depends_on = [kubernetes_cluster_role_binding.tiller-cluster-admin]
}

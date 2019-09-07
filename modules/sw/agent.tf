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

  set {
    name = "secrets.pullSecretEnabled"
    value = var.pull_secret_enabled
  }

  set {
    name = "secrets.pullServiceAccountKey.projectId"
    value = "${var.pull_secret_account_project_id}"
  }

  set {
    name = "secrets.pullServiceAccountKey.privateKeyId"
    value = "${var.pull_secret_account_private_key_id}"
  }

  set {
    name = "secrets.pullServiceAccountKey.privateKey"
    value = "${var.pull_secret_account_private_key}"
  }

  set {
    name = "secrets.pullServiceAccountKey.clientEmail"
    value = "${var.pull_secret_account_client_email}"
  }

  set {
    name = "secrets.pullServiceAccountKey.clientId"
    value = "${var.pull_secret_account_client_id}"
  }

  set {
    name = "secrets.pullServiceAccountKey.clientX509CertUrl"
    value = "${var.pull_secret_account_client_cert_url}"
  }

  timeout = 300
  depends_on = [kubernetes_cluster_role_binding.tiller-cluster-admin]
}

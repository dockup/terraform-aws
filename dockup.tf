data "helm_repository" "dockup-helm" {
    name = "dockup"
    url  = "https://helm-charts.getdockup.com"
}

resource "helm_release" "dockup-agent" {
  name = "dockup-agent"
  repository = "${data.helm_repository.dockup-helm.metadata.0.name}"
  chart = "agent"

  set {
    name = "dockupApiKey"
    value = "${var.agent-api-key}"
  }
}
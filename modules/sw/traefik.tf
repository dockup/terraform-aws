#
# Helm setup to get agent up and running!
#  * Following https://docs.getdockup.com/how-tos/set-up-dockup-agent-on-aws
#  * Installs helm chart for dockup agent
#

resource "helm_release" "traefik" {
  name = "traefik"
  chart = "stable/traefik"

  set {
    name = "accessLogs.enabled"
    value = true
  }

  set {
    name = "ssl.enabled"
    value = true
  }

  set {
    name = "ssl.enforced"
    value = true
  }

  set {
    name = "ssl.insecureSkipVerify"
    value = true
  }

  set {
    name = "rbac.enabled"
    value = "true"
  }

  set {
    name = "deployment.hostPort.httpsEnabled"
    value = true
  }

  set {
    name = "service.nodePorts.http"
    value = "80"
  }

  set {
    name = "service.nodePorts.https"
    value = "443"
  }

  set {
    name = "acme.enabled"
    value = true
  }

  set {
    name = "acme.email"
    value = var.traefik_acme_email
  }

  set {
    name = "acme.staging"
    value = false
  }

  set {
    name = "acme.logging"
    value = true
  }

  set {
    name = "acme.challengeType"
    value = "dns-01"
  }

  set {
    name = "acme.domains.enabled"
    value = true
  }

  set {
    name = "acme.domains.domainsList[0].main"
    value = var.traefik_wildcard_domain
  }

  set {
    name = "acme.dnsProvider.name"
    value = var.traefik_dns_provider
  }

  set {
    name = "acme.dnsProvider.gandiv5.GANDIV5_API_KEY"
    value = var.traefik_gandiv5_key
  }


  timeout = 300
  depends_on = [kubernetes_cluster_role_binding.tiller-cluster-admin]
}

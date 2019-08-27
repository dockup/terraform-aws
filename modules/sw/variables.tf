#
# Variables Configuration
#

variable "agent_key" {
  default = "dockup-agent-key"
  type    = "string"
}

variable "cluster_name" {}
variable "cluster_region" {}
variable "cluster_host" {}
variable "cluster_cert" {}
variable "cluster_token" {}


variable "traefik_acme_email" {
  default = "team@getdockup.com"
  type = "string"
}

variable "traefik_wildcard_domain" {
  default = "*.static.dockup.xyz"
  type = "string"
}

# Note that you need to directly modify dns credentials for traefik config
variable "traefik_dns_provider" {
  default = "gandiv5"
  type = "string"
}

variable "traefik_gandiv5_key" {
  default = "gandiv5-key"
  type = "string"
}

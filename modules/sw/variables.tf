#
# Variables Configuration
#

variable "agent_key" {
  default = "dockup-agent-key"
  type    = "string"
}

variable "agent_dockup_host" {
  default = "getdockup.com"
  type = "string"
}

variable "agent_image_tag" {
  default = "latest"
  type = "string"
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

variable "pull_secret_enabled" {
  default = true
  type = bool
}

variable "pull_secret_account_project_id" {
  default = "gcp-project-id"
  type = "string"
}

variable "pull_secret_account_private_key_id" {
  default = "gcp-private-key-id"
  type = "string"
}

# Make sure that \n is replaced with \\\\n here. Lots of escaping!
variable "pull_secret_account_private_key" {
  default = "gcp-private-key-slash-n-separated"
  type = "string"
}

variable "pull_secret_account_client_email" {
  default = "gcp-project-client-email"
  type = "string"
}

variable "pull_secret_account_client_id" {
  default = "gcp-project-client-id"
  type = "string"
}

variable "pull_secret_account_client_cert_url" {
  default = "gcp-project-client-cert-url"
  type = "string"
}

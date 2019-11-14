#
# Variables Configuration
#

variable "cluster_name" {}
variable "cluster_region" {}
variable "cluster_host" {}
variable "cluster_cert" {}
variable "cluster_token" {}


# Configure Agent
variable "agent_key" {
  default = "dockup-agent-key"
  type = string
}

variable "agent_dockup_host" {
  default = "getdockup.com"
  type = string
}

variable "agent_image_tag" {
  default = "latest"
  type = string
}

variable "agent_pull_secret_base64" {
  default = ""
  type = string
}

variable "agent_timber_source_id" {
  default = "timber-source-id"
  type = string
}

variable "agent_timber_api_key" {
  default = "timber-api-key"
  type = string
}

# Configure Traefik
variable "traefik_acme_email" {
  default = "dockup@yourdomain.com"
  type = string
}

variable "traefik_wildcard_domain" {
  default = "*.static.dockup.xyz"
  type = string
}

# Note that you need to directly modify dns credentials for traefik config
variable "traefik_dns_provider" {
  default = "gandiv5"
  type = string
}

variable "traefik_gandiv5_key" {
  default = "gandi-pai-key"
  type = string
}

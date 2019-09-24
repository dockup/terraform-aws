#
# Variables Configuration
#

variable "cluster_name" {
  type = string
}

variable "cluster_admins_arns" {
  default = []                  # arns of users
  type = list(string)
}

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

variable "pull_secret_enabled" {
  default = false
  type = bool
}

variable "pull_secret_account_project_id" {
  default = "gcp-project-id"
  type = string
}

variable "pull_secret_account_private_key_id" {
  default = "gcp-private-key-id"
  type = string
}

variable "pull_secret_account_private_key" {
  default = "gcp-private-key"
  type = string
}

variable "pull_secret_account_client_email" {
  default = "gcp-account-email"
  type = string
}

variable "pull_secret_account_client_id" {
  default = "gcp-account-id"
  type = string
}

variable "pull_secret_account_client_cert_url" {
  default = "gcp-secret-cert-url"
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

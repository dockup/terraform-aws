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

variable "persistence_ebs_volumes_count" {
  default = 0
  type = number
}

variable "persistence_ebs_volumes_size" {
  default = 1
  type = number
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

variable "agent_pull_secret_base64" {
  default = ""
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

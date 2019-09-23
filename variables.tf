#
# Variables Configuration
#

variable "cluster_name" {
  default = "dockup"
  type    = "string"
}

variable "cluster_admins_arns" {
  default = []                  # arns of users
  type = "list"
}

variable "agent_key" {
  default = "dockup-api-key"
  type    = "string"
}

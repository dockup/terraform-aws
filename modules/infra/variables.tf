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

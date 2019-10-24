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

variable "persistence_ebs_volumes_count" {
  default = 0
  type = number
}

variable "persistence_ebs_volumes_size" {
  default = 1
  type = number
}

# Configure RDS
variable "pg_user" {
  default = "dockup_user"
  type = string
}

variable "pg_password" {
  default = "sup3rs3cr3tpAssw0rd"
  type = string
}

variable "pg_port" {
  default = 5432
  type = number
}
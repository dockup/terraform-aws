#
# Variables Configuration
#

variable "cluster-name" {
  default = "terraform-eks-dockup"
  type    = "string"
}

variable "organization-name" {
  type = "string"
}

variable "agent-api-key" {
  type = "string"
}

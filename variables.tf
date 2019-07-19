#
# Variables Configuration
#

variable "cluster-name" {
  default = "eks-dockup"
  type    = "string"
}

variable "organization-name" {
  type = "string"
}

variable "agent-api-key" {
  type = "string"
}

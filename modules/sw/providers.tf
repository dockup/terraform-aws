#
# Provider Configuration
#

provider "aws" {
  version = "~> v2.22.0"
  region = "us-west-2"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}


# Kubernetes provider for attaching nodes to EKS cluster
# programatically
provider "kubernetes" {
  host = "${var.cluster_host}"
  cluster_ca_certificate = "${var.cluster_cert}"
  token = "${var.cluster_token}"
  load_config_file = false
}


# Helm provider to install agent and dependencies
provider "helm" {
  service_account = "tiller"

  kubernetes {
    host = "${var.cluster_host}"
    cluster_ca_certificate = "${var.cluster_cert}"
    token = "${var.cluster_token}"
    load_config_file = false
  }
}

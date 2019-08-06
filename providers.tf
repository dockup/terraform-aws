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
  host = "${aws_eks_cluster.dockup.endpoint}"
  cluster_ca_certificate = "${base64decode(aws_eks_cluster.dockup.certificate_authority.0.data)}"
  token = "${data.aws_eks_cluster_auth.dockup.token}"
  load_config_file = false
}

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

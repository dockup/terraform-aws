# main module. Sets up infra and sofware components.
#
terraform {
  required_version = "~> 0.12.4"

  backend "remote" {}
}

module "infra" {
  source = "./modules/infra"
}

module "sw" {
  source = "./modules/sw"

  cluster_name = "${module.infra.cluster_name}"
  cluster_region = "${module.infra.cluster_region}"
  cluster_host = "${module.infra.cluster_host}"
  cluster_cert = "${module.infra.cluster_cert}"
  cluster_token = "${module.infra.cluster_token}"
}

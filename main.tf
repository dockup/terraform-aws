# main module. Sets up infra and sofware components.
#
terraform {
  required_version = "~> 0.12.4"
}

module "infra" {
  source = "./modules/infra"

  cluster_name = var.cluster_name
  cluster_admins_arns = var.cluster_admins_arns
  persistence_ebs_volumes_count = var.persistence_ebs_volumes_count
  persistence_ebs_volumes_size = var.persistence_ebs_volumes_size
}

module "sw" {
  source = "./modules/sw"

  agent_key = var.agent_key
  agent_dockup_host = var.agent_dockup_host
  agent_image_tag = var.agent_image_tag
  agent_pull_secret_base64 = var.agent_pull_secret_base64
  agent_timber_source_id = var.agent_timber_source_id
  agent_timber_api_key = var.agent_timber_api_key

  traefik_acme_email = var.traefik_acme_email
  traefik_wildcard_domain = var.traefik_wildcard_domain
  traefik_dns_provider = var.traefik_dns_provider
  traefik_gandiv5_key = var.traefik_gandiv5_key

  cluster_name = module.infra.cluster_name
  cluster_region = module.infra.cluster_region
  cluster_host = module.infra.cluster_host
  cluster_cert = module.infra.cluster_cert
  cluster_token = module.infra.cluster_token
}

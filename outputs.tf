#
# Outputs
#

output "kubeconfig" {
  value = "${module.infra.kubeconfig}"
}

output "persistence_ids" {
  value = module.infra.persistence_ids
}

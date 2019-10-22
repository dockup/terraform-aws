#
# Outputs
#

output "kubeconfig" {
  value = "${module.infra.kubeconfig}"
}

output "persistence_ids" {
  value = module.infra.persistence_ids
}

output "this_db_instance_endpoint" {
  description = "The connection endpoint"
  value       = "${module.infra.this_db_instance_endpoint}"
}

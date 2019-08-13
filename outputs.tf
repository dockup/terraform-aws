#
# Outputs
#

output "kubeconfig" {
  value = "${module.infra.kubeconfig}"
}

output "virtual_machine_ids" {
  description = "Ids of the deployed virtual machines"
  value       = zipmap([for k, v in var.virtual_machines : k], [for k, v in var.virtual_machines : module.virtual_machines[k].virtual_machine_id])
}
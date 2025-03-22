output "virtual_machine_ids" {
  description = "Ids of the deployed virtual machines"
  value       = [for x in var.var.virtual_machines : module.virtual_machines[x].virtual_machine_id]
}
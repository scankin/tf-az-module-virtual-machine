output "virtual_machine_id" {
  description = "ID of the Virtual Machine."
  value       = var.os_type == "windows" ? azurerm_windows_virtual_machine.this[0].id : azurerm_linux_virtual_machine.this[0].id
}
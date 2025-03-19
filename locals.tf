locals {
  network_interface_ids = concat([azurerm_network_interface.this.id], var.network_interface_ids)
}
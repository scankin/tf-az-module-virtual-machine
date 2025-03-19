module "virtual_machines" {
  for_each = var.virtual_machines

  source = "../"

  virtual_machine_name = replace(local.virtual_machine_name, "__key__", each.key)
  resource_group_name  = azurerm_resource_group.this.name
  location             = var.location

  admin_username = random_pet.this.id
  admin_password = random_password.this.result

  os_type                = each.value.os_type
  source_image_reference = each.value.source_image_reference
  size                   = each.value.size
  ip_configuration       = each.value.ip_configuration
  managed_disks          = each.value.managed_disks
  subnet_id              = azurerm_subnet.this["vms"].id

  tags = local.tags
}
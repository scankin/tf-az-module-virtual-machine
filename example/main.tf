## Common Resources
#####################
resource "azurerm_resource_group" "this" {
  name     = local.resource_group_name
  location = var.location
}

resource "random_pet" "this" {
  separator = "-"
}

resource "random_password" "this" {
  length           = 8
  special          = true
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  min_lower        = 1
  override_special = "!@#$%&*()-=+[]{}<>:?"
}

## Networking Resources
########################
resource "azurerm_virtual_network" "this" {
  name                = local.virtual_network_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  address_space       = [var.address_space]

  tags = local.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.address_prefix]
}
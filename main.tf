# Virtual Machine Resources
resource "azurerm_windows_virtual_machine" "this" {
  count = var.os_type == "windows" ? 1 : 0

  name                = var.virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location

  computer_name = var.hostname
  size          = var.size

  admin_username = var.admin_username
  admin_password = var.admin_password

  network_interface_ids = local.network_interface_ids

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_reference[*]
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "this" {
  count = var.os_type == "linux" ? 1 : 0

  name                = var.virtual_machine_name
  resource_group_name = var.resource_group_name
  location            = var.location

  computer_name = var.hostname
  size          = var.size

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = var.admin_password == null ? true : false

  network_interface_ids = local.network_interface_ids

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  dynamic "source_image_reference" {
    for_each = var.source_image_reference[*]
    content {
      publisher = source_image_reference.value.publisher
      offer     = source_image_reference.value.offer
      sku       = source_image_reference.value.sku
      version   = source_image_reference.value.version
    }
  }

  tags = var.tags
}

resource "azurerm_managed_disk" "this" {
  for_each = var.managed_disks

  name = join("-", [
    var.virtual_machine_name,
    "disk",
    "0${index(keys(var.managed_disks), each.key)}"
  ])
  resource_group_name = var.resource_group_name
  location            = var.location

  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  disk_size_gb         = each.value.disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "this" {
  for_each = var.managed_disks

  managed_disk_id    = azurerm_managed_disk.this[each.key].id
  virtual_machine_id = var.os_type == "windows" ? azurerm_windows_virtual_machine.this[0].id : azurerm_linux_virtual_machine.this[0].id
  lun                = index(keys(var.managed_disks), each.key)
  caching            = each.value.caching
}

# Networking Resources
resource "azurerm_network_interface" "this" {
  name                = join("-", ["nic", var.virtual_machine_name])
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = join("-", ["ip", "conf", var.virtual_machine_name])
    private_ip_address_allocation = var.ip_configuration.private_ip_address_allocation
    private_ip_address_version    = var.ip_configuration.private_ip_address_version
    private_ip_address            = var.ip_configuration.private_ip_address
    subnet_id                     = var.subnet_id
    primary                       = true
  }
}
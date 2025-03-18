## Common Variables
###########################
service          = "dem"
location         = "uksouth"
environment_code = "dev"

## Networking Variables
###########################
address_space = "10.0.0.0/8"
subnets = {
  vms = {
    address_prefix = "10.0.0.0/27"
  }
}

## Virtual Machine Variables
###########################
virtual_machines = {
  win = {
    os_type = "windows"
    size    = "Standard_B1s"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2022-Datacenter"
      version   = "latest"
    }
    ip_configuration = {
      private_ip_address_allocation = "Static"
      private_ip_address            = "10.0.0.5"
    }
  },
  lin = {
    os_type = "linux"
    size    = "Standard_B1s"
    os_disk = {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }
    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts"
      version   = "latest"
    }
    ip_configuration = {
      private_ip_address_allocation = "Static"
      private_ip_address            = "10.0.0.4"
    }
  }
}
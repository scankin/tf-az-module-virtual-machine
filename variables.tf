## Common Variables
##################################
variable "virtual_machine_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group to deploy the virtual network to."
}

variable "location" {
  type        = string
  description = "The value of the location for the Virtual Network to be deployed"
}

variable "tags" {
  type        = map(any)
  description = "Map value of key:pair values indicating tags"
  default = {
    terraform = "true"
  }
}

## Virtual Machine Variables
##################################
variable "os_type" {
  type        = string
  description = "The OS type of the virtual machine, either 'windows' or 'linux'."
  validation {
    condition = contains([
      "windows",
      "linux"
    ], var.os_type)
    error_message = "OS Type must either by 'windows' or 'linux'."
  }
}

variable "managed_disks" {
  type = map(object({
    caching              = optional(string, "ReadWrite")
    create_option        = optional(string, "Empty")
    storage_account_type = optional(string, "Standard_LRS")
    disk_size_gb         = string
  }))
  description = <<DESC
    A map of objects containing the details for managed disks for the virtual machine.
  DESC
  default     = {}
}

variable "hostname" {
  type        = string
  description = "The hostname of the virtual machine."
  default     = null
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
  description = <<DESC
    Object containing the configuration for the virtual machine OS Disk

    os_disk = {
        caching              = string - Type of caching to be used by the internal OS Disk
        storage_account_type = string - The type of storage which should back the internal OS Disk
    }
  DESC
  validation {
    condition = contains([
      "None",
      "ReadOnly",
      "ReadWrite"
    ], var.os_disk.caching)
    error_message = "Caching value must be 'None', 'ReadOnly' or 'ReadWrite'"
  }
  validation {
    condition = contains([
      "Standard_LRS",
      "StandardSSD_LRS",
      "StandardSSD_ZRS",
      "Premium_LRS",
      "Premium_ZRS"
    ], var.os_disk.storage_account_type)
    error_message = "Storage Account Type must be 'Standard_LRS', 'StandardSSD_LRS', 'StandardSSD_ZRS','Premium_LRS' or 'Premium_ZRS'"
  }
  default = {
    caching              = "None",
    storage_account_type = "Standard_LRS"
  }
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = <<DESC
    source_image_reference = {
        publisher = string - Publisher of the image for virtual machine creation.
        offer     = string - Offer of the image for virtual machine creation.
        sku       = string - SKU of the image to be used for virtual machine creation.
        version   = string - Version of the image to be used for virtual machine creation.
    }
  DESC
  default     = null
}

variable "ip_configuration" {
  type = object({
    private_ip_address_allocation = optional(string, "Dynamic")
    private_ip_address_version    = optional(string, "IPv4")
    private_ip_address            = optional(string, null)
  })
  validation {
    condition = contains([
      "Dynamic",
      "Static"
    ], var.ip_configuration.private_ip_address_allocation)
    error_message = "Private IP Allocation must be either 'Dynamic' or 'Static'."
  }
  validation {
    condition = contains([
      "IPv4",
      "IPv6"
    ], var.ip_configuration.private_ip_address_version)
    error_message = "Private IP Address Version must be either 'IPv4' or 'IPv6'."
  }
  validation {
    condition = var.ip_configuration.private_ip_address == null ? true : can(
      regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}$", var.ip_configuration.private_ip_address)
    )
    error_message = "The Private IP address must be a valid IP address."
  }
  description = <<DESC
    ip_configuration = object({
      private_ip_address_allocation = optional(string, "Dynamic") - IP Address Allocation for the Virtual Machines default NIC (Options are 'Static or 'Dynamic', defaults to 'Dynamic')
      private_ip_address_version    = optional(string, "IPv4")    - Private IP Address Version, options are 'IPv4' or 'IPv6', defaults to 'IPv4'
      private_ip_address            = optional(string, null)      - The Private IP Address of the NIC (Optional)
    })
  DESC
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet which the Virtual Machine should be deployed to."
}

variable "size" {
  type        = string
  description = "The size of the Virtual Machine SKU."
}

variable "admin_username" {
  type        = string
  description = "The username to use for the virtual machine admin user."
}

variable "admin_password" {
  type        = string
  description = "The password to use for the virtual machine admin user."
  sensitive   = true
}

variable "network_interface_ids" {
  type        = list(string)
  description = "A list of additional Network Interface cards to be connected to the virtual machine."
  default     = []
}
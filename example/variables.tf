## Common Variables
###########################
variable "service" {
  type = string
  validation {
    condition     = can(regexall("^[a-z]{1,4}$", var.service))
    error_message = "Service must be a lower case letter and no longer than 3 characters"
  }
  description = "Service name for the configuration."
}

variable "location" {
  type = string
  validation {
    condition = contains([
      "uksouth",
      "ukwest"
    ], var.location)
    error_message = "The location must be either 'uksouth' or 'ukwest'"
  }
  description = "The location value for the deployment."
}

variable "environment_code" {
  type = string
  validation {
    condition = contains([
      "dev",
      "tst"
    ], var.environment_code)
    error_message = "Environment code must be either 'dev', or 'tst'."
  }
  description = "The short code for the deployed environment."
}

variable "address_space" {
  type = string
  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}(\\/[0-9]{1,2})$", var.address_space))
    error_message = "${var.address_space} is not a valid CIDR range."
  }
  description = "The CIDR range of the Virtual Network to be deployed."
}

variable "subnets" {
  type = map(object({
    address_prefix = string
  }))
  description = <<DESC
    Map of objects containing the subnet address prefix for the virtual network.

    address_prefix - CIDR value for the subnet.
  DESC
  default     = {}
}

## Virtual Machine Variables
variable "virtual_machines" {
  type = map(object({
    os_type = string
    size    = string
    os_disk = object({
      caching              = string
      storage_account_type = string
    })
    managed_disks = map(object({
      caching              = string
      create_option        = string
      storage_account_type = string
      disk_size_gb         = string
    }))
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    ip_configuration = object({
      private_ip_address_allocation = optional(string, "Dynamic")
      private_ip_address_version    = optional(string, "IPv4")
      private_ip_address            = optional(string, null)
    })
  }))
  description = "A map of objects containing the configuration for the virtual machines"
}
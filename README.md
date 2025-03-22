
## Introduction
The following repository contains terraform code for a Azure Virtual Machine, either Linux or Windows

The following module creates
- A single Virtual Machine (Either Windows or Linux)
- A single NIC for the Virtual Machine
- A number of managed disks connected to the virtual machine

This module is not for commercial use, and has purely been created for lab exercises and own use.

## Example Deployment
The `example/` folder contains an example configuration for deploying this module. The variables for this deployment can be found within the `vars/` folder.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_virtual_machine_id"></a> [virtual\_machine\_id](#output\_virtual\_machine\_id) | ID of the Virtual Machine. |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | The password to use for the virtual machine admin user. | `string` | n/a | yes |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | The username to use for the virtual machine admin user. | `string` | n/a | yes |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | The hostname of the virtual machine. | `string` | `null` | no |
| <a name="input_ip_configuration"></a> [ip\_configuration](#input\_ip\_configuration) | ip\_configuration = object({<br/>      private\_ip\_address\_allocation = optional(string, "Dynamic") - IP Address Allocation for the Virtual Machines default NIC (Options are 'Static or 'Dynamic', defaults to 'Dynamic')<br/>      private\_ip\_address\_version    = optional(string, "IPv4")    - Private IP Address Version, options are 'IPv4' or 'IPv6', defaults to 'IPv4'<br/>      private\_ip\_address            = optional(string, null)      - The Private IP Address of the NIC (Optional)<br/>    }) | <pre>object({<br/>    private_ip_address_allocation = optional(string, "Dynamic")<br/>    private_ip_address_version    = optional(string, "IPv4")<br/>    private_ip_address            = optional(string, null)<br/>  })</pre> | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The value of the location for the Virtual Network to be deployed | `string` | n/a | yes |
| <a name="input_managed_disks"></a> [managed\_disks](#input\_managed\_disks) | A map of objects containing the details for managed disks for the virtual machine. | <pre>map(object({<br/>    caching              = optional(string, "ReadWrite")<br/>    create_option        = optional(string, "Attach")<br/>    storage_account_type = optional(string, "Standard_LRS")<br/>    disk_size_gb         = string<br/>  }))</pre> | `{}` | no |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | A list of additional Network Interface cards to be connected to the virtual machine. | `list(string)` | `[]` | no |
| <a name="input_os_disk"></a> [os\_disk](#input\_os\_disk) | Object containing the configuration for the virtual machine OS Disk<br/><br/>    os\_disk = {<br/>        caching              = string - Type of caching to be used by the internal OS Disk<br/>        storage\_account\_type = string - The type of storage which should back the internal OS Disk<br/>    } | <pre>object({<br/>    caching              = string<br/>    storage_account_type = string<br/>  })</pre> | <pre>{<br/>  "caching": "None",<br/>  "storage_account_type": "Standard_LRS"<br/>}</pre> | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | The OS type of the virtual machine, either 'windows' or 'linux'. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group to deploy the virtual network to. | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | The size of the Virtual Machine SKU. | `string` | n/a | yes |
| <a name="input_source_image_reference"></a> [source\_image\_reference](#input\_source\_image\_reference) | source\_image\_reference = {<br/>        publisher = string - Publisher of the image for virtual machine creation.<br/>        offer     = string - Offer of the image for virtual machine creation.<br/>        sku       = string - SKU of the image to be used for virtual machine creation.<br/>        version   = string - Version of the image to be used for virtual machine creation.<br/>    } | <pre>object({<br/>    publisher = string<br/>    offer     = string<br/>    sku       = string<br/>    version   = string<br/>  })</pre> | `null` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the subnet which the Virtual Machine should be deployed to. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map value of key:pair values indicating tags | `map(any)` | <pre>{<br/>  "terraform": "true"<br/>}</pre> | no |
| <a name="input_virtual_machine_name"></a> [virtual\_machine\_name](#input\_virtual\_machine\_name) | The name of the virtual network. | `string` | n/a | yes |  

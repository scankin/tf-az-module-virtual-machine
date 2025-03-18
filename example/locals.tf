locals {
  ## Common Locals
  ############################
  location_shortcode = {
    uksouth = "uks"
    ukwest  = "ukw"
  }

  name_suffix = join("-", [
    local.location_shortcode[var.location],
    var.environment_code
  ])

  tags = {
    service       = var.service,
    environment   = var.environment_code,
    last_deployed = formatdate("MM/DD/YY hh:mm", timestamp())
  }

  ## Resource Naming
  ############################
  resource_group_name = join("-", [
    var.service,
    "vms",
    "rg",
    local.name_suffix
  ])

  virtual_network_name = join("-", [
    var.service,
    "vnet",
    local.name_suffix
  ])

  virtual_machine_name = join("-", [
    var.service,
    "__key__",
    local.name_suffix
  ])
}

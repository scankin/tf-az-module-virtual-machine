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
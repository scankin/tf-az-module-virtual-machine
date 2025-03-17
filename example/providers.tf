terraform {
  required_version = "~> 1.9.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.23.0"
    }
  }
}

provider "azurerm" {
  features {}
}
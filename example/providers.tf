terraform {
  required_version = "~> 1.9.3"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.23.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.7.1"
    }
  }
}

provider "azurerm" {
  features {}
}
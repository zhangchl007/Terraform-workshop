terraform {
  required_version = ">=1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.23.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfdemo"
    storage_account_name = "tfdemotfstate21052"
    container_name       = "tfvmdemo01"
    key                  = "azuresaforeachdemo.tfstate"
  }
}

provider "azapi" {
}

provider "azurerm" {
  features {}
}

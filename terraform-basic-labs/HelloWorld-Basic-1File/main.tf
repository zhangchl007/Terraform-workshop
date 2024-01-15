# Ensure Azure CLI Connection: az login
terraform {
  required_version = ">= 1.5.7" 
  required_providers {
     azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.23.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
  }
  
}

provider "azurerm" {
  features {}
  
}

resource "azurerm_resource_group" "rg" {
  location = "eastus"
  name     = "TF-Helloworld-Basic"
}

# Generate random value for the storage account name
resource "random_string" "storage_account_name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage_account" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  #name = random_string.storage_account_name.result
  name = "tf${random_string.storage_account_name.result}"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_container" "container_name" {
  name                  = "private"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}




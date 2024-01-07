terraform {
  required_version = ">= 0.13"
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
    key                  = "tfvm01demo.tfstate"
  }
}

provider "azapi" {
}

provider "azurerm" {
  features {}
  subscription_id = "ffa067fd-36c1-4774-a161-7ebdac9a934f"
  tenant_id       = "16b3c013-d300-468d-ac64-7eda0820b6d3"
  client_id       = "ba681a28-1e4a-4bb7-862b-08b5a771e650"
  client_secret   = "-fQ8Q~UkcX4tLI_RIJSbChOamKqXaCUGUTrLHblq"
}

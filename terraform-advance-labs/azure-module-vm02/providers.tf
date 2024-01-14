terraform {

  #Uncomment this block to use Terraform Cloud for this tutorial
  /*cloud {
    organization = "devops-learn-terraform"
    workspaces {
      name = "azure-module-vm02"
    }
}*/

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
    key                  = "tfmodulevm02.tfstate"
  }
}

provider "azapi" {
   alias  = "chazapi"

}

provider "azurerm" {
  features {}
}

/*
module "linux-instance" {
  source = "./modules/"
  providers = {
    azapi = azapi.chazapi
  }
  
}*/


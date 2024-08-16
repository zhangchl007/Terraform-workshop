# Private AKS Terraform
This is a Terraform script to create a private AKS cluster in Azure. The script creates a VNET, a subnet, a private AKS cluster

# Bootstrap
./tf-bootstrap.sh

# Configuration

```bash

cat <<EOF > terraform.tfvars

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
    null = {
      source  = "hashicorp/null"
      version = "~>3.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfdemo"
    storage_account_name = "tfdemotfstate$RANDOM"
    container_name       = "tfstate$RANDOM"
    key                  = "tfaks.tfstate"
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

EOF

```

# Running the script
After you configure authentication with Azure, just init and apply (no inputs are required):

```bash
export ARM_USE_MSI=true
export ARM_SUBSCRIPTION_ID= `az account show --query id -o tsv`
export ARM_TENANT_ID = `az account show --query tenantId -o tsv`
export ARM_ACCESS_KEY=`az keyvault secret show --name terraform-backend-key --vault-name tfstatevault --query value -o tsv`

```

`terraform init`

`terraform apply`

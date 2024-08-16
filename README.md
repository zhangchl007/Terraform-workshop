# Learn Terraform with Azure

This is the companion code from the HashiCorp Learn tutorial


## Terraform basic  2 days

```
input variables
output variables
local variables
expression
depends on
count
for each
Functions
tf workflow

```

## Terrafrom advance 2days

```
bootstrapping
module
advance command
3rd party tools
Terragrunt

``` 

## GitAction 1day

```
GitAction + Terraform

```

## Azure CAF 2days

```
CAF landing Zone/ China 

```

# Terraform Azure Module

This is a Terraform script for learning purposes. 

# Bootstrap
./tf-bootstrap.sh

# Configuration

```bash

cat <<EOF > providers.tf

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

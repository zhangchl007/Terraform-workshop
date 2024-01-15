## Store Terraform state in Azure Storage

- create storage account

```
vi tf-bootstrap.sh

#!/bin/bash

RESOURCE_GROUP_NAME=tfdemo
STORAGE_ACCOUNT_NAME=tfdemotfstate$RANDOM
CONTAINER_NAME=tfstate$RANDOM

# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME

```

## Create Storage Account

```bash

sh tf-bootstrap.sh

```

## Setup Terraform state

- Enable Storage Account for Terraform state

```
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

export ARM_ACCESS_KEY=$(az keyvault secret show --name mykeyvaultzhangchl007 --vault-name tfKeyVault --query value -o tsv)

```

- Get key vault

```
RESOURCE_GROUP_NAME=tfdemo
STORAGE_ACCOUNT_NAME=tfdemotfstate21052
CONTAINER_NAME=tfvmdemo01
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

```


## define the backend

```

vi backend.tf

terraform {
  required_version = ">= 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.23.0"
    }
  }
   backend "azurerm" {
      resource_group_name  = "tfdemo"
      storage_account_name = "tfdemotfstate21052"
      container_name       = "tfvmdemo01"
      key                  = "tfvm01demo.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id   = "xxxx"
  tenant_id         = "yyyy"
  client_id         = "zzzz"
  client_secret     = "mmmm"
}

```

### Reference Documentation

 
For further reference, please consider the following sections:

(Terrafrom developer) https://developer.hashicorp.com/terraform/tutorials/azure-get-started/# 
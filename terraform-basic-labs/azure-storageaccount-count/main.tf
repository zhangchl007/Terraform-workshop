//data "azurerm_client_config" "current" {}

locals {
  name_suffix = "${var.resource_tags["project"]}-${var.resource_tags["environment"]}"
  rg_prefix   = var.resource_group_name_prefix
}

# Generate random resource group name
#resource "random_pet" "rg_name" {
# prefix = var.resource_group_name_prefix
#}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${local.rg_prefix}-${local.name_suffix}"
  #name     = random_pet.rg_name.id 
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
  count               = var.storage_account_number
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = "${random_string.storage_account_name.result}${count.index}"

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_blob" "example" {
  name                   = "index.html"
  for_each = {
    for k,v in azurerm_storage_account.storage_account : k => v
  }
  storage_account_name   = each.value.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}
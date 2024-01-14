//data "azurerm_client_config" "current" {}

locals {
  name_suffix = "${var.resource_tags["project"]}-${var.resource_tags["environment"]}"
  rg_prefix = var.resource_group_name_prefix
  storage_account_name = {
    "sa1"={name="sa1",tier="Standard",replication_type="LRS",kind="StorageV2"},
    "sa2"={name="sa2",tier="Standard",replication_type="LRS",kind="StorageV2"},
    "sa3"={name="sa3",tier="Standard",replication_type="LRS",kind="StorageV2"}
  }
}

# Generate random resource group name
#resource "random_pet" "rg_name" {
# prefix = var.resource_group_name_prefix
#}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name = "${local.rg_prefix}-${local.name_suffix}"
  #name     = random_pet.rg_name.id 
}

# Generate random value for the storage account name
resource "random_string" "storage_account_name" {
  length  = 5
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage_account" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  for_each = local.storage_account_name
  name ="${each.key}${random_string.storage_account_name.result}"
  account_tier             = each.value.tier
  account_replication_type = each.value.replication_type
  account_kind             = each.value.kind

  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_blob" "example" {
  name                   = "index.html"
  for_each = local.storage_account_name
  storage_account_name   = azurerm_storage_account.storage_account[each.key].name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "index.html"
}
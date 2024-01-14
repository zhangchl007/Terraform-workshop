

locals {
  prefix     = var.demo_prefix
  public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey

}

resource "random_pet" "rg_name" {
  prefix = var.demo_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

// create virtual network and subnets

module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = azurerm_resource_group.rg.name
  vnet_name           = "labVnet"
  address_spaces      = ["10.0.0.0/16", "10.2.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "subnet3"]

  subnet_service_endpoints = {
    "subnet1" : ["Microsoft.Web"],
    "subnet2" : ["Microsoft.Sql"],
    "subnet3" : ["Microsoft.AzureCosmosDB"]
  }
  use_for_each = true
  tags = {
    environment = "dev"
    costcenter  = "it"
  }

  depends_on = [azurerm_resource_group.rg]
}


# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = "myNetworkSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

module "virtual_machine1" {
  source         = "./modules/linux-instance"
  rg_name        = azurerm_resource_group.rg.name
  location       = azurerm_resource_group.rg.location
  #subnet_id      = module.network.vnet_subnets[0]
  subnet_id = module.network.vnet_subnets[0]
  vmnsg_id       = azurerm_network_security_group.my_terraform_nsg.id
  prefix         = local.prefix
  username       = var.username
  vm_size        = var.vm_size
  ssh_public_key = local.public_key
}


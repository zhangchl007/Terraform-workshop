

locals {
  prefix = var.demo_prefix
  public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  private_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).privateKey

}

resource "random_pet" "rg_name" {
  prefix = var.demo_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}


# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = "mySubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]
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

resource "null_resource" "name" {
  provisioner "local-exec" {
    command = "echo hello >> hostname.txt"
  }

  provisioner "file" {
  source      = "hostname.txt"
  destination = "/tmp/hostname.txt"

  connection {
    type     = "ssh"
    user     = "${var.username}"
    host     = module.virtual_machine1.public_ip_address
    private_key = "${local.private_key}"
    timeout = "2m"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo touch /etc/motd",
      "sudo chmod 777 /etc/motd",
      "sudo echo 'Welcome to mydemo' > /etc/motd",
    ]
    connection {
    type     = "ssh"
    user     = "${var.username}"
    host     = module.virtual_machine1.public_ip_address
    private_key = "${local.private_key}"
    timeout = "2m"
    }
  }
  
}

module "virtual_machine1" {
  source    = "./modules/linux-instance"
  rg_name   = azurerm_resource_group.rg.name
  location  = azurerm_resource_group.rg.location
  subnet_id = azurerm_subnet.my_terraform_subnet.id
  vmnsg_id  = azurerm_network_security_group.my_terraform_nsg.id
  prefix    = local.prefix
  username  = var.username
  vm_size   = var.vm_size
  ssh_public_key = local.public_key
}


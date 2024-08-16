#resource "azurerm_resource_group" "vnet" {
#  name     = var.vnet_resource_group_name
#  location = var.location
#}

resource "random_pet" "rg" {
  length = 1
  prefix = var.dns_prefix
}

resource "azurerm_resource_group" "kube" {
  name     = var.kube_resource_group_name
  location = var.location
  tags = {
    environment = "Demo"
  }
}

module "kube_network" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.kube.name
  location            = var.location
  vnet_name           = var.kube_vnet_name
  address_space       = ["10.4.0.0/22"]
  subnets = [
    {
      name : "node-subnet"
      address_prefixes : ["10.4.0.0/24"]
    },
    {
      name : "pod-subnet"
      address_prefixes : ["10.4.1.0/24"]
    }
  ]
}

resource "azurerm_kubernetes_cluster" "k8s" {
  name                    = "private-aks"
  location                = var.location
  kubernetes_version      = data.azurerm_kubernetes_service_versions.current.latest_version
  resource_group_name     = azurerm_resource_group.kube.name
  dns_prefix              = "private-aks"
  private_cluster_enabled = true

  default_node_pool {
    name           = "default"
    node_count     = var.nodepool_nodes_count
    vm_size        = var.nodepool_vm_size
    vnet_subnet_id = module.kube_network.subnet_ids["node-subnet"]
    pod_subnet_id  = module.kube_network.subnet_ids["pod-subnet"]

  }

  identity {
    #type = "SystemAssigned"
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks.id]
  }

  network_profile {
    dns_service_ip    = var.network_dns_service_ip
    network_plugin    = "azure"
    network_policy    = "calico"
    load_balancer_sku = "standard"
    service_cidr      = var.network_service_cidr

  }

  linux_profile {
    admin_username = var.username

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  depends_on = [ azurerm_user_assigned_identity.aks ]

}

resource "azurerm_kubernetes_cluster_node_pool" "paas"{

  name = "paas"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s.id
  vm_size = var.nodepool_vm_size
  node_count = 3
  os_disk_size_gb = 500
  os_type = "Linux"
  vnet_subnet_id = module.kube_network.subnet_ids["node-subnet"]
  pod_subnet_id  = module.kube_network.subnet_ids["pod-subnet"]
  depends_on = [azurerm_kubernetes_cluster.k8s]

}
#resource "azurerm_role_assignment" "netcontributor" {
#  role_definition_name = "Network Contributor"
#  scope                = module.kube_network.subnet_ids["node-subnet"]
#  principal_id         = azurerm_kubernetes_cluster.k8s.identity[0].principal_id
#}





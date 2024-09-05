resource "azurerm_user_assigned_identity" "aks" {
  location            = azurerm_resource_group.kube.location
  name                = "${random_pet.rg.id}-aksmi"
  resource_group_name = azurerm_resource_group.kube.name
}

resource "azurerm_role_assignment" "aks_network" {
  scope                = module.kube_network.subnet_ids["node-subnet"]
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

 # Assign Network Contributor role to the AKS service principal for the Application Gateway subnet.
resource "azurerm_role_assignment" "aks_appgw_subnet" {
  principal_id   = azurerm_kubernetes_cluster.k8s.ingress_application_gateway[0].ingress_application_gateway_identity[0].object_id
  role_definition_name = "Network Contributor"
  scope          = module.kube_network.subnet_ids["appgw-subnet"]
}

resource "azurerm_role_assignment" "aks_acr" {
  scope                = azurerm_container_registry.default.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}
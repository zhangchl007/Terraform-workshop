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

resource "azurerm_role_assignment" "aks_acr" {
  scope                = azurerm_container_registry.default.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}
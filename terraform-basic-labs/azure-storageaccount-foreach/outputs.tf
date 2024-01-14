output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "storage_account_name" {
  value = [ for storage_account in azurerm_storage_account.storage_account: storage_account.name ]
}

output "primary_web_host" {
  value = [ for storage_account in azurerm_storage_account.storage_account: storage_account.primary_web_host ]
}
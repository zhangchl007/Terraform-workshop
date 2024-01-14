output "resource_group_name" {
  value = var.rg_name
}
output "vm_name" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.name
  
}
output "public_ip_address" {
  value = azurerm_linux_virtual_machine.my_terraform_vm.public_ip_address
}
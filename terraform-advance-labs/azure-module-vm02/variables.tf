variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

variable "demo_prefix" {
  type        = string
  default     = "mylab"
  description = "Prefix of the resource name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}

variable "vm_size" {
  type        = string
  description = "SKU of vm."
  default     = "Standard_DS1_v2"
}
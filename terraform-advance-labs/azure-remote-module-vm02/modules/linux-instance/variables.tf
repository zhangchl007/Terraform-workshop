variable "location" {
  type        = string
  description = "Location of the resource group."
}

variable "rg_name" {
  type        = string
  description = "Name of the resource group."
}

variable "prefix" {
  type        = string
  description = "Prefix of resource name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
}

variable "subnet_id" {
  type = string
  description = "the subnet_id."
}
variable "vm_size" {
  type = string
  description = "SKU of vm."
}

variable "vmnsg_id" {

  type = string
  description = "Security Group of vm."
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key used for authentication."
  
}
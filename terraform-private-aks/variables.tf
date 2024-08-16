variable "location" {
  description = "The resource group location"
  default     = "West US 2"
}

#variable "vnet_resource_group_name" {
#  description = "The resource group name to be created"
#  default     = "rg-aks-kubedemo"
#}

variable "kube_vnet_name" {
  description = "AKS VNET name"
  default     = "aks-kubevnet"
}

variable "kube_version_prefix" {
  description = "AKS Kubernetes version prefix. Formatted '[Major].[Minor]' like '1.18'. Patch version part (as in '[Major].[Minor].[Patch]') will be set to latest automatically."
  default     = "1.28"
}

variable "kube_resource_group_name" {
  description = "The resource group name to be created"
  default     = "rg-aks-tfdemo"
}

variable "nodepool_nodes_count" {
  description = "Default nodepool nodes count"
  default     = 2
}

variable "nodepool_vm_size" {
  description = "Default nodepool VM size"
  default     = "Standard_D4_v3"
}

variable "network_dns_service_ip" {
  description = "CNI DNS service IP"
  default     = "178.51.0.10"
}

variable "network_service_cidr" {
  description = "CNI service cidr"
  default     = "178.51.0.0/16"
}

variable "network_pod_cidr" {
  description = "CNI pod cidr"
  default     = "10.4.1.0/24"
}

variable "username" {
  description = "The username for the AKS cluster"
  default     = "azureuser"

}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "cluster_name" {
  type        = string
  description = "AKS Cluster Name"
  default     = "private-aks"
}

variable "dns_prefix" {
  type        = string
  description = "DNS Prefix"
  default     = "tf"
}
variable "subnets" {
  description = "The list of subnets to be created"
  type = list(object({
    name             = string
    address_prefixes = list(string)
  }))

  default = [
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
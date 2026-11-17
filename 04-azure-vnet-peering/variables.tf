
variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "Canada Central"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-vnet-peering"
}

variable "vnet_dev_name" {
  description = "Development VNet name"
  type        = string
  default     = "vnet-dev"
}

variable "vnet_prod_name" {
  description = "Production VNet name"
  type        = string
  default     = "vnet-prod"
}

variable "dev_address_space" {
  description = "Development VNet address space"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "prod_address_space" {
  description = "Production VNet address space"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "dev_subnet_prefix" {
  description = "Development subnet address range"
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "prod_subnet_prefix" {
  description = "Production subnet address range"
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

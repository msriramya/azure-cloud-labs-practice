
variable "location" {
  description = "Azure region"
  type        = string
  default     = "canadacentral"
}

variable "resource_group_name" {
  description = "Project resource group"
  type        = string
  default     = "rg-ha-nginx"
}

variable "admin_username" {
  description = "Linux VM administrator username"
  type        = string
  default     = "azureadmin"
}

variable "admin_password" {
  description = "Linux VM administrator password"
  type        = string
  sensitive   = true
}

variable "vm_size" {
  description = "Linux VM size"
  type        = string
  default     = "Standard_B2ats_v2"
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "web_subnet_prefix" {
  description = "Web subnet address range"
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

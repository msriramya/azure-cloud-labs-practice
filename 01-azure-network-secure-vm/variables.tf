
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
  description = "Resource group name"
  type        = string
  default     = "rg-network-securevm"
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
  description = "Azure virtual machine size"
  type        = string
  default     = "Standard_B2ats_v2"
}

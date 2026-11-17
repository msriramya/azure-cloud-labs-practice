
output "resource_group_name" {
  description = "Created Resource Group"
  value       = azurerm_resource_group.peering_rg.name
}

output "dev_vnet_name" {
  description = "Development VNet name"
  value       = azurerm_virtual_network.vnet_dev.name
}

output "dev_vnet_address_space" {
  description = "Development VNet CIDR"
  value       = azurerm_virtual_network.vnet_dev.address_space
}

output "prod_vnet_name" {
  description = "Production VNet name"
  value       = azurerm_virtual_network.vnet_prod.name
}

output "prod_vnet_address_space" {
  description = "Production VNet CIDR"
  value       = azurerm_virtual_network.vnet_prod.address_space
}

output "dev_subnet_id" {
  description = "Development subnet ID"
  value       = azurerm_subnet.subnet_dev.id
}

output "prod_subnet_id" {
  description = "Production subnet ID"
  value       = azurerm_subnet.subnet_prod.id
}

output "dev_to_prod_peering_id" {
  description = "Development to Production peering ID"
  value       = azurerm_virtual_network_peering.dev_to_prod.id
}

output "prod_to_dev_peering_id" {
  description = "Production to Development peering ID"
  value       = azurerm_virtual_network_peering.prod_to_dev.id
}


output "resource_group_name" {
  value = azurerm_resource_group.lab.name
}

output "virtual_network_name" {
  value = azurerm_virtual_network.lab.name
}

output "workload_subnet_id" {
  value = azurerm_subnet.workload.id
}

output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}

output "vm_name" {
  description = "Name of the Linux virtual machine"
  value       = azurerm_linux_virtual_machine.web.name
}

output "vm_private_ip" {
  value = azurerm_network_interface.vm.private_ip_address
}

output "vm_has_public_ip" {
  value = false
}

output "bastion_name" {
  value = azurerm_bastion_host.lab.name
}


output "resource_group_name" {
  value = azurerm_resource_group.lab.name
}

output "load_balancer_name" {
  value = azurerm_lb.web.name
}

output "load_balancer_public_ip" {
  description = "Public IP address of the website"
  value       = azurerm_public_ip.lb.ip_address
}

output "website_url" {
  description = "URL to access the NGINX website"
  value       = "http://${azurerm_public_ip.lb.ip_address}"
}

output "vm_names" {
  value = {
    for key, vm in azurerm_linux_virtual_machine.web :
    key => vm.name
  }
}

output "vm_private_ips" {
  value = {
    for key, vm in azurerm_linux_virtual_machine.web :
    key => vm.private_ip_address
  }
}

output "backend_pool_name" {
  value = azurerm_lb_backend_address_pool.web.name
}

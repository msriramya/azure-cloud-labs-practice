
# Network interfaces for both VMs
resource "azurerm_network_interface" "web" {
  for_each = local.vm_instances

  name                = "nic-${each.value.name}"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.web.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Register both VM NICs in the Load Balancer backend pool
resource "azurerm_network_interface_backend_address_pool_association" "web" {
  for_each = local.vm_instances

  network_interface_id    = azurerm_network_interface.web[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id
}

# Create both Ubuntu Linux VMs
resource "azurerm_linux_virtual_machine" "web" {
  for_each = local.vm_instances

  name                = each.value.name
  computer_name       = each.value.name
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  size                = var.vm_size
  zone                = each.value.zone

  admin_username                  = var.admin_username
  admin_password                  = var.admin_password
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.web[each.key].id
  ]

  custom_data = base64encode(
    templatefile("${path.module}/cloud-init.yaml", {
      server_name   = each.value.name
      server_number = each.key
    })
  )

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = null
  }

  depends_on = [
    azurerm_network_interface_backend_address_pool_association.web,
    azurerm_lb_outbound_rule.web
  ]
}

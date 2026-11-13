
# Public IP for the Load Balancer
resource "azurerm_public_ip" "lb" {
  name                = "pip-ha-nginx"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name

  allocation_method = "Static"
  sku               = "Standard"
  zones             = ["1", "2", "3"]
}

# Azure Standard Load Balancer
resource "azurerm_lb" "web" {
  name                = "lb-ha-nginx"
  location            = azurerm_resource_group.lab.location
  resource_group_name = azurerm_resource_group.lab.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicFrontend"
    public_ip_address_id = azurerm_public_ip.lb.id
  }
}

# Backend pool
resource "azurerm_lb_backend_address_pool" "web" {
  name            = "backend-pool-nginx"
  loadbalancer_id = azurerm_lb.web.id
}

# HTTP health probe
resource "azurerm_lb_probe" "http" {
  name            = "probe-http"
  loadbalancer_id = azurerm_lb.web.id

  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

# HTTP load balancing rule
resource "azurerm_lb_rule" "http" {
  name                           = "rule-http"
  loadbalancer_id                = azurerm_lb.web.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicFrontend"

  backend_address_pool_ids = [
    azurerm_lb_backend_address_pool.web.id
  ]

  probe_id              = azurerm_lb_probe.http.id
  disable_outbound_snat = true
}

# Explicit outbound connectivity for the backend VMs
resource "azurerm_lb_outbound_rule" "web" {
  name                    = "outbound-rule-web"
  loadbalancer_id         = azurerm_lb.web.id
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web.id

  allocated_outbound_ports = 1000
  idle_timeout_in_minutes  = 15
  enable_tcp_reset         = true

  frontend_ip_configuration {
    name = "PublicFrontend"
  }
}

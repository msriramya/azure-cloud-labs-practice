##Create RG
resource "azurerm_resource_group" "peering_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "Learning"
    project     = "Azure-VNet-Peering"
  }
}
##Create VNets
resource "azurerm_virtual_network" "vnet_dev" {
  name                = var.vnet_dev_name
  address_space       = var.dev_address_space
  location            = azurerm_resource_group.peering_rg.location
  resource_group_name = azurerm_resource_group.peering_rg.name

  tags = {
    environment = "Development"
  }
}

resource "azurerm_virtual_network" "vnet_prod" {
  name                = var.vnet_prod_name
  address_space       = var.prod_address_space
  location            = azurerm_resource_group.peering_rg.location
  resource_group_name = azurerm_resource_group.peering_rg.name

  tags = {
    environment = "Production"
  }
}
##Create Subnets (Prod and Dev)

resource "azurerm_subnet" "subnet_dev" {
  name                 = "subnet-dev"
  resource_group_name  = azurerm_resource_group.peering_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_dev.name
  address_prefixes     = var.dev_subnet_prefix
}

resource "azurerm_subnet" "subnet_prod" {
  name                 = "subnet-prod"
  resource_group_name  = azurerm_resource_group.peering_rg.name
  virtual_network_name = azurerm_virtual_network.vnet_prod.name
  address_prefixes     = var.prod_subnet_prefix
}

##Create NSGs and security rules

resource "azurerm_network_security_group" "nsg_dev" {
  name                = "nsg-dev"
  location            = azurerm_resource_group.peering_rg.location
  resource_group_name = azurerm_resource_group.peering_rg.name

  security_rule {
    name                       = "Allow-ICMP-From-Prod"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.20.0.0/16"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "nsg_prod" {
  name                = "nsg-prod"
  location            = azurerm_resource_group.peering_rg.location
  resource_group_name = azurerm_resource_group.peering_rg.name

  security_rule {
    name                       = "Allow-ICMP-From-Dev"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "10.10.0.0/16"
    destination_address_prefix = "*"
  }
}
##Associate NSG with Subnets

resource "azurerm_subnet_network_security_group_association" "dev_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet_dev.id
  network_security_group_id = azurerm_network_security_group.nsg_dev.id
}

resource "azurerm_subnet_network_security_group_association" "prod_nsg_association" {
  subnet_id                 = azurerm_subnet.subnet_prod.id
  network_security_group_id = azurerm_network_security_group.nsg_prod.id
}

##Configure VNet Peering (Dev->Prod)

resource "azurerm_virtual_network_peering" "dev_to_prod" {
  name                      = "peer-dev-to-prod"
  resource_group_name       = azurerm_resource_group.peering_rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_dev.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_prod.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

##Configure VNet Peering (Prod-> Dev)

resource "azurerm_virtual_network_peering" "prod_to_dev" {
  name                      = "peer-prod-to-dev"
  resource_group_name       = azurerm_resource_group.peering_rg.name
  virtual_network_name      = azurerm_virtual_network.vnet_prod.name
  remote_virtual_network_id = azurerm_virtual_network.vnet_dev.id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  allow_gateway_transit        = false
  use_remote_gateways          = false

  depends_on = [
    azurerm_virtual_network_peering.dev_to_prod
  ]
}

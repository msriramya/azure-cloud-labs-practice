terraform {
  required_providers {
    azurerm={
        source = "hashicorp/azurerm"
        version = "~>4.81.0"
    }
  }
}
provider "azurerm" {
    features {
    }
}

#resource_group

resource "azurerm_resource_group" "rg1" {
    name= "demorg"
    location =" canadacentral"
  
}
resource "azurerm_storage_account" "example" {
  name                     = "practicetframya2424"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}
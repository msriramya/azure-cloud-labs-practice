
resource "azurerm_resource_group" "lab" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    environment = "learning"
    project     = "highly-available-nginx"
    managed_by  = "terraform"
  }
}

locals {
  vm_instances = {
    web01 = {
      name = "vm-nginx-web01"
      zone = "1"
    }

    web02 = {
      name = "vm-nginx-web02"
      zone = "2"
    }
  }
}

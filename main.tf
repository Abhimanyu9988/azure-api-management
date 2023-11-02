terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.78.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.azurerm_api_management}-${random_string.name_suffix.result}"
  location = var.location
}

resource "random_string" "name_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_api_management" "azurerm_api_management" {
  name                = "${var.azurerm_api_management}-${random_string.name_suffix.result}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email

  sku_name = "Standard_1"

  identity {
    type = "SystemAssigned"
  }
}

output "api_management_gateway_url" {
  value = azurerm_api_management.azurerm_api_management.gateway_url
}

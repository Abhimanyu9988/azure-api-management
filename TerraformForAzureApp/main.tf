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
  name     = var.resource_group
  location = var.location
}

resource "azurerm_service_plan" "asp" {
  name                = var.service_plan_name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  os_type             = "Linux"
  sku_name = "P1v3"
}

resource "random_string" "name_suffix" {
  length  = 6
  special = false
  upper   = false
}

####Create a web app
####alwebapp=azurerm_linux_web_app
resource "azurerm_linux_web_app" "linux_webapp" {
  name                = "${var.web_app_name}-${random_string.name_suffix.result}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  service_plan_id = azurerm_service_plan.asp.id
  public_network_access_enabled = true

  site_config {
    application_stack {
      docker_image_name = "abhimanyubajaj98/flask-demo:latest"
      docker_registry_url = "https://index.docker.io"
    
      #To list all the available stacks, run az webapp list-runtimes --linux
    }
  }
}

output "resource_group_name" {
    value = azurerm_resource_group.resource_group.name
}

output "service_plan_id" {
    value = azurerm_service_plan.asp.id
}

output "webapp_name" {
    value = azurerm_linux_web_app.linux_webapp.name
}
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "azurerm" {
  features {}

  
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "helm-chart" {
  name     = "helm-chart-group"
  location = "West Europe"
}

resource "azurerm_virtual_network" "helm-chart" {
  name                = "helm-chart-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.helm-chart.location
  resource_group_name = azurerm_resource_group.helm-chart.name
}

resource "azurerm_subnet" "helm-chart" {
  name                 = "helm-chart-subnet"
  resource_group_name  = azurerm_resource_group.helm-chart.name
  virtual_network_name = azurerm_virtual_network.helm-chart.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Sql", "Microsoft.Storage"]
}

resource "azurerm_storage_account" "helm-chart" {
  name                     = "helm${random_string.resource_code.result}"
  resource_group_name      = azurerm_resource_group.helm-chart.name
  location                 = azurerm_resource_group.helm-chart.location
  account_tier             = "Standard"
  access_tier = "Cool"
  account_replication_type = "GRS"
  
  network_rules {
    default_action = "Deny"
    ip_rules = ["100.0.0.1"]
    virtual_network_subnet_ids = [azurerm_subnet.helm-chart.id]
  }

  tags = {
	environment = "production"
  }
}

resource "azurerm_storage_container" "helm-chart" {
  name                  = "helm-chart-container"
  storage_account_name  = azurerm_storage_account.helm-chart.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "helm-chart" {
  name                   = "helm-blob"
  storage_account_name   = azurerm_storage_account.helm-chart.name
  storage_container_name = azurerm_storage_container.helm-chart.name
  type                   = "Block"
  source                 = "helm-repo.txt"
}

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.helm-chart.primary_access_key
}

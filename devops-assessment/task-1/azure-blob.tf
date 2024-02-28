terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
    features {}
    skip_provider_registration = true
}


# resource "random_string" "resource_code" {
#   length  = 5
#   special = false
#   upper   = false
# }

resource "azurerm_resource_group" "helmchart" {
  name     = "helmchartgroup"
  location = "East US"
}

resource "azurerm_storage_account" "helmchart" {
  # name                     = "helmstorage${random_string.resource_code.result}"
  name                     = "helmstoragea49hm"
  resource_group_name      = azurerm_resource_group.helmchart.name
  location                 = azurerm_resource_group.helmchart.location
  account_tier             = "Standard"
  access_tier              = "Hot"
  account_replication_type = "GRS"

  tags = {
	environment = "production"
  }
}

resource "azurerm_storage_container" "helmchart" {
  name                  = "helm-chart-container"
  storage_account_name  = azurerm_storage_account.helmchart.name
  container_access_type = "private"
}

# resource "azurerm_storage_blob" "helmchart" {
#   name                   = "helm-blob"
#   storage_account_name   = azurerm_storage_account.helmchart.name
#   storage_container_name = azurerm_storage_container.helmchart.name
#   type                   = "Block"
#   source                 = "helm-repo.txt"
# }

output "storage_account_primary_access_key" {
  value = azurerm_storage_account.helmchart.primary_access_key
  sensitive = true
}
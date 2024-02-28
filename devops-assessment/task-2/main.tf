terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.93.0"
    }
  }
}



resource "azurerm_resource_group" "example" {
  name     = "example-resource-group"
  location = "East US"
}

resource "azurerm_key_vault" "example" {
  name                = "example-key-vault"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  enabled_for_disk_encryption = true
  tenant_id           = "<Your Tenant ID>"
  sku_name            = "standard"

  access_policy {
    tenant_id = "<Your Tenant ID>"
    object_id = "<Your Object ID>"

    key_permissions = [
      "get",
      "list",
    ]

    secret_permissions = [
      "get",
      "list",
    ]
  }
}

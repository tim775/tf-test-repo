provider "azurerm" {
  skip_provider_registration = true
  features {}
}

resource "azurerm_resource_group" "arg" {
  name     = "arg"
  location = "westus"
}

resource "azurerm_storage_account" "existing_passing" {
  name                     = "existing_passing"
  resource_group_name      = azurerm_resource_group.arg.name
  location                 = azurerm_resource_group.arg.location
  account_kind             = "BlobStorage"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  blob_properties {
    last_access_time_enabled = true
  }
}

resource "azurerm_storage_account" "existing_failing" {
  name                     = "existing_failing"
  resource_group_name      = azurerm_resource_group.arg.name
  location                 = azurerm_resource_group.arg.location
  account_kind             = "BlobStorage"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  blob_properties {
  }
}

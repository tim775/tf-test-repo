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

resource "azurerm_storage_management_policy" "existing_passing" {
  storage_account_id = azurerm_storage_account.existing_passing.id
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

resource "azurerm_storage_account" "new_passing" {
  name                     = "new_passing"
  resource_group_name      = azurerm_resource_group.arg.name
  location                 = azurerm_resource_group.arg.location
  account_kind             = "BlobStorage"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  blob_properties {
    last_access_time_enabled = true
  }
}

resource "azurerm_storage_management_policy" "new_passing" {
  storage_account_id = azurerm_storage_account.existing_passing.id
}


resource "azurerm_storage_account" "new_failing" {
  name                     = "new_failing"
  resource_group_name      = azurerm_resource_group.arg.name
  location                 = azurerm_resource_group.arg.location
  account_kind             = "BlobStorage"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  blob_properties {
  }
}

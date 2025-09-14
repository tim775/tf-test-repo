provider "azurerm" {
  skip_provider_registration = true
  features {}
}

module "database_tier" {
  for_each = var.clusters
  source   = "../../.github/actions/devops/terraform/modules/rds-aurora"
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

resource "azurerm_linux_virtual_machine_scale_set" "failing_ds2_v2" {
  name                = "failing-Standard_DS2_v2"
  resource_group_name = "fake_resource_group"
  location            = "eastus"
  instances           = 3

  sku            = "Standard_D4S_v3"
  admin_username = "fakeuser"
  admin_password = "Password1234!"

  network_interface {
    name    = "example"
    primary = true

    ip_configuration {
      name      = "internal"
      primary   = true
      subnet_id = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/testrg/providers/Microsoft.Network/virtualNetworks/test1/subnets/fakesubnet"
    }
  }

  tags = {
    mustincludetagkey = ""
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

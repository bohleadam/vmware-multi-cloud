provider "azurerm" {
  features {}

  subscription_id = var.arm_subscription_id
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  tenant_id       = var.arm_tenant_id

  disable_correlation_request_id = true
}

resource "azurerm_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_vmware_private_cloud" {
  name                = var.azurerm_vmware_private_cloud_name
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku_name            = var.azurerm_vmware_private_cloud_sku

  management_cluster {
    size = var.azurerm_vmware_private_cloud_host_count
  }

  network_subnet_cidr = var.azurerm_vmware_private_cloud_management_cidr
  internet_connection_enabled = false
}

provider "azurerm" {
  features {}

  subscription_id = var.arm_subscription_id
  client_id       = var.arm_client_id
  client_secret   = var.arm_client_secret
  tenant_id       = var.arm_tenant_id

  disable_correlation_request_id = true
}

# Azure VMWare Solution Resource

resource "azurerm_resource_group" "avs_resource_group" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_vmware_private_cloud" "avs_sddc" {
  name                = var.azurerm_vmware_private_cloud_name
  resource_group_name = azurerm_resource_group.avs_resource_group.name
  location            = azurerm_resource_group.avs_resource_group.location
  sku_name            = var.azurerm_vmware_private_cloud_sku

  management_cluster {
    size = var.azurerm_vmware_private_cloud_host_count
  }

  network_subnet_cidr = var.azurerm_vmware_private_cloud_management_cidr
  internet_connection_enabled = false
}

resource "azurerm_virtual_network" "mca-vnet-demo" {
  name                = "mca-vnet-demo"
  location            = azurerm_resource_group.avs_resource_group.location
  resource_group_name = azurerm_resource_group.avs_resource_group.name
  address_space       = var.azurerm_virtual_network_address_space

subnet {
  name           = "mca-vnet-demo-subnet-1"
  address_prefix = var.azurerm_virtual_network_subnet_1
  }
}

# Azure Public IP for Network Gateway

resource "azurerm_public_ip" "mca-network-gateway-public-ip-address-demo" {
  name                = "mca-network-gateway-public-ip-address-demo"
  location            = azurerm_resource_group.avs_resource_group.location
  resource_group_name = azurerm_resource_group.avs_resource_group.name

  allocation_method = "Dynamic"
}

# Azure Virtual Network Gateway (ExpressRoute)

resource "azurerm_subnet" "VNG_GatewaySubnet" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.avs_resource_group.name
  virtual_network_name = azurerm_virtual_network.mca-vnet-demo.name
  address_prefixes     = var.azurerm_vng_gateway_subnet
}

resource "azurerm_virtual_network_gateway" "mca-network-gateway-demo" {
  name                = "mca-network-gateway-demo"
  location            = azurerm_resource_group.avs_resource_group.location
  resource_group_name = azurerm_resource_group.avs_resource_group.name

  type     = "ExpressRoute"
  sku      = "Standard"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.mca-network-gateway-public-ip-address-demo.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.VNG_GatewaySubnet.id
  }
}
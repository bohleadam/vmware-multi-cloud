# Multi-Cloud Lab Terraform Variables

## Azure Connection Details Variables

variable "arm_client_id" {
    description = "Application (Client ID)"
}

variable "arm_client_secret" {
    description = "Client Secret Value"
}

variable "arm_subscription_id" {
    description = "Azure Subscription ID"
}

variable "arm_tenant_id" {
    description = "Directory tenant ID"
}

## Azure VMware Solution Variables

variable "resource_group_name" {
    description = "Azure Resource Group Name"
}

variable "resource_group_location" {
    description = "Azure Resource Group Location"
}

variable "azurerm_vmware_private_cloud_name" {
    description = "Name of the AVS SDDC"
}

variable "azurerm_vmware_private_cloud_sku" {
    description = "The host type used for AVS"
}

variable "azurerm_vmware_private_cloud_management_cidr" {
    description = "This is the management network CIDR range"
}

variable "azurerm_vmware_private_cloud_host_count" {
    description = "Number of hosts in the SDDC"
}

## Azure VNET Variables

variable "azurerm_virtual_network_address_space" {
    description = "Address Space for the VNET"
}

variable "azurerm_virtual_network_subnet_1" {
    description = "Address Space for the VNET Subnet 1"
}

# Azure Virtual Network Gateway Variables

variable "azurerm_vng_gateway_subnet" {
    description = "Virtual Network Gateway Subnet"
}

variable "api_token" {
    description = "VMware CSP Portal API token"
}

variable "sddc_region" {
    description = "AWS Region in which to deploy the SDDC"
}

variable "sddc_name" {
    description = "VMC SDDC Name"
}
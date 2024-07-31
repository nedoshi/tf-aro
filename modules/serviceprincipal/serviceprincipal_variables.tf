# Variables
variable "spoke_rg_name" {
  type = string
}

variable "hub_rg_name" {
  type = string
}

variable "aro_spn_name" {
  type = string
}

data "azurerm_resource_group" "spoke" {
    name = var.spoke_rg_name
}

data "azurerm_resource_group" "hub" {
    name = var.hub_rg_name
}

data "azuread_client_config" "current" {}

data "azurerm_subscription" "current" {}

# Needed so we can assign it the 'Network Contributor' role on the created VNet
data "azuread_service_principal" "aro_resource_provisioner" {
    display_name            = "Azure Red Hat OpenShift RP"
}
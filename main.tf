locals {
  name_prefix = var.cluster_name
  pull_secret = var.pull_secret_path != null && var.pull_secret_path != "" ? file(var.pull_secret_path) : null
}

# Resource Groups
resource "azurerm_resource_group" "hub" {
  name     = var.hub_name
  location = var.location
}

resource "azurerm_resource_group" "spoke" {
  name     = var.spoke_name
  location = var.location
}
resource "azurerm_log_analytics_workspace" "la" {
  name                = var.hub_name
  location            = var.location
  resource_group_name = azurerm_resource_group.hub.name
  sku                 = "PerGB2018"
}

module "vnet" {
  source = "./modules/vnet"

  hub_name    = var.hub_name
  hub_rg_name = azurerm_resource_group.hub.name

  spoke_name    = var.spoke_name
  spoke_rg_name = azurerm_resource_group.spoke.name

  diag_name = "${var.hub_name}${random_string.random.result}"

  location = var.location
  la_id    = azurerm_log_analytics_workspace.la.id
}


module "serviceprincipal" {
  source = "./modules/serviceprincipal"

  aro_spn_name = var.aro_spn_name
  spoke_rg_name = azurerm_resource_group.spoke.name
  hub_rg_name = azurerm_resource_group.hub.name

  depends_on = [
    module.vnet
  ]

}




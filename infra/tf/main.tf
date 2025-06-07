provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "main" {
  name     = "zettademo1"
  location = "West Europe"
}

resource "azurerm_container_registry" "acr" {
  name                = "zettademo1acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = "zettademo1"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "zettademo1"

  default_node_pool {
    name            = "default"
    node_count      = 1
    vm_size         = "Standard_B1s"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.29.2"

  depends_on = [azurerm_container_registry.acr]
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  principal_id        = azurerm_kubernetes_cluster.main.identity[0].principal_id
  role_definition_name = "AcrPull"
  scope               = azurerm_container_registry.acr.id
}

resource "azurerm_kubernetes_cluster_node_pool" "defaultnp" {
  name                  = "defaultnp"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main.id
  vm_size               = "Standard_B1s"
  node_count            = 1
  os_disk_size_gb       = 30
  mode                  = "User"
  orchestrator_version  = azurerm_kubernetes_cluster.main.kubernetes_version

  node_labels = {
    environment = "dev"
  }
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.main.kube_config_raw
  sensitive = true
}

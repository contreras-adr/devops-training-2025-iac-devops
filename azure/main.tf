
resource "azurerm_resource_group" "main" {
  name     = "${var.project_name}-rg"
  location = var.location

  tags = {
    Project     = var.project_name
    Environment = "dev"
    Owner       = "devops-training-2025"
    CostCenter  = "training-2025"
  }
}

resource "azurerm_log_analytics_workspace" "logs" {
  name                = "${var.project_name}-logs"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    Project = var.project_name
  }
}

resource "azurerm_container_app_environment" "env" {
  name                       = "${var.project_name}-env"
  location                   = var.location
  resource_group_name        = azurerm_resource_group.main.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.logs.id

  tags = {
    Project = var.project_name
  }
}

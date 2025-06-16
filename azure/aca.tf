
resource "azurerm_container_app" "webapp" {
  name                         = "${var.project_name}-webapp"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = azurerm_resource_group.main.name
  location                     = var.location
  revision_mode                = "Single"

  template {
    container {
      name   = "webapp"
      image  = "mcr.microsoft.com/java/jdk:17-ubuntu"

      resources {
        cpu    = 0.25
        memory = "0.5Gi"
      }
    }

    scale {
      min_replicas = 0
      max_replicas = 2
    }
  }

  ingress {
    external_enabled = true
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  tags = {
    Project = var.project_name
  }
}

resource "azurerm_container_app" "postgres" {
  count                        = var.use_managed_postgres ? 0 : 1
  name                         = "${var.project_name}-postgres"
  container_app_environment_id = azurerm_container_app_environment.env.id
  resource_group_name          = azurerm_resource_group.main.name
  location                     = var.location
  revision_mode                = "Single"

  template {
    container {
      name   = "postgres"
      image  = "postgres:15"

      env {
        name  = "POSTGRES_DB"
        value = "mydb"
      }

      env {
        name  = "POSTGRES_USER"
        value = "admin"
      }

      env {
        name  = "POSTGRES_PASSWORD"
        value = "adminpass"
      }

      resources {
        cpu    = 0.25
        memory = "0.5Gi"
      }
    }

    scale {
      min_replicas = 0
      max_replicas = 1
    }
  }

  ingress {
    external_enabled = false
    target_port      = 5432
  }

  tags = {
    Project = var.project_name
  }
}

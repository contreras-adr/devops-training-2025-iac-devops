
resource "azurerm_postgresql_flexible_server" "postgres" {
  count               = var.use_managed_postgres ? 1 : 0
  name                = "${var.project_name}-psql"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  version             = "15"
  sku_name            = "B1ms"
  storage_mb          = 32768
  administrator_login          = "admin"
  administrator_password       = "adminpass123!"
  zone                      = "1"
  delegated_subnet_id       = null
  private_dns_zone_id       = null
  publicly_accessible       = true

  high_availability {
    mode = "Disabled"
  }

  backup {
    backup_retention_days        = 7
    geo_redundant_backup_enabled = false
  }

  tags = {
    Project = var.project_name
  }
}

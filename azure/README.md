
# Azure Terraform Project – Container Apps + PostgreSQL (Flexible or Containerized)

## Opciones
- WebApp Java pública
- PostgreSQL privada:
  - En contenedor (Container Apps)
  - O como servicio gestionado (Flexible Server)

## Uso
```bash
terraform init
terraform apply -var="use_managed_postgres=true"
```

## Personalización
Puedes usar `use_managed_postgres=false` para probar PostgreSQL en contenedor.


                        ┌────────────────────────────┐
                        │        Azure Region        │
                        │         westeurope         │
                        └────────────┬───────────────┘
                                      │
                      ┌──────────────▼──────────────┐
                      │   Resource Group (RG)       │
                      └──────┬────────────┬─────────┘
                              │            │
            ┌────────────────▼─┐        ┌──▼────────────────┐
            │   Log Analytics  │        │ Container Apps Env│
            │  Workspace (30d) │        │     (pay-per-use) │
            └──────────────────┘        └────────┬──────────┘
                                                │
                          ┌─────────────────────▼─────────────────────┐
                          │     Container App: Java WebApp (public)   │
                          │   - Auto-scaling: 0 ↔ 2 replicas           │
                          │   - Ingress público (puerto 80)           │
                          └─────────────────────┬─────────────────────┘
                                                │
                                                │
  ┌─────────────────────────────────────────────▼──────────────────────────────────────────────┐
  │                             PostgreSQL (solo una opción activa)                            │
  │                                                                                             │
  │  ➤ Opción 1: Container App Postgres (privado)                                                │
  │     - Escala 0 ↔ 1                                                                           │
  │     - Ingresos internos (puerto 5432)                                                        │
  │                                                                                             │
  │  ➤ Opción 2: Azure PostgreSQL Flexible Server (gestionado)                                   │
  │     - SKU B1ms, sin HA, sin redundancia geográfica                                           │
  │     - Backup: 7 días                                                                         │
  └─────────────────────────────────────────────────────────────────────────────────────────────┘

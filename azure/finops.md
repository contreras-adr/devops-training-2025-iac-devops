
# FinOps Strategy for Azure Container Apps + PostgreSQL Flexible Server

## Conditional PostgreSQL Deployment
You can choose:
- Containerized PostgreSQL for short-term dev/test
- Managed PostgreSQL Flexible Server for reliable, production-grade databases

## Tagging for Cost Management
All resources are tagged with:
- `Project`, `Owner`, `Environment`, `CostCenter`

## Container Apps
- Scaled to zero when idle
- Resource-limited (0.25 vCPU, 0.5Gi RAM)
- Logs retained only 30 days

## Managed PostgreSQL (Flexible Server)
- Basic SKU used (`B1ms`)
- Backups retained 7 days
- Geo-redundancy disabled for cost saving


variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "project_name" {
  description = "Project name for tagging and resource naming"
  type        = string
  default     = "aca-finops-demo"
}

variable "use_managed_postgres" {
  description = "Whether to use Azure Database for PostgreSQL instead of containerized Postgres"
  type        = bool
  default     = true
}

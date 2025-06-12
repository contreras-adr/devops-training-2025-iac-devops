
variable "use_rds" {
  description = "Whether to deploy PostgreSQL in RDS instead of ECS"
  type        = bool
  default     = true
}

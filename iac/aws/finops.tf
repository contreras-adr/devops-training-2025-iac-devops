resource "aws_cloudwatch_log_group" "webapp" {
  name              = "/ecs/webapp"
  retention_in_days = 7
}

resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
  tags = {
    Project = "ECS-Demo"
  }
}


resource "aws_ecs_task_definition" "postgres" {
  count                    = var.use_rds ? 0 : 1
  family                   = "postgres-db"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "postgres"
    image     = "postgres:15"
    essential = true
    environment = [
      { name = "POSTGRES_DB", value = "mydb" },
      { name = "POSTGRES_USER", value = "admin" },
      { name = "POSTGRES_PASSWORD", value = "adminpass" }
    ]
    portMappings = [{
      containerPort = 5432
      hostPort      = 5432
    }]
  }])
}

resource "aws_ecs_service" "postgres" {
  count           = var.use_rds ? 0 : 1
  name            = "postgres-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.postgres[0].arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [aws_security_group.db_sg.id]
    assign_public_ip = false
  }

  tags = {
    Project = "ECS-Demo"
  }
}

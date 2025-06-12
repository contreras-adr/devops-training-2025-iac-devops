
resource "aws_ecs_cluster" "main" {
  name = "ecs-cluster"
}

resource "aws_cloudwatch_log_group" "webapp" {
  name              = "/ecs/webapp"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "webapp" {
  family                   = "java-webapp"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "webapp"
    image     = "${aws_ecr_repository.webapp_repo.repository_url}:latest"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
    }]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        awslogs-group         = aws_cloudwatch_log_group.webapp.name
        awslogs-region        = "eu-west-1"
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "webapp" {
  name            = "webapp-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.webapp.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = module.vpc.public_subnets
    security_groups = [aws_security_group.web_sg.id]
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "postgres" {
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
  name            = "postgres-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.postgres.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = module.vpc.private_subnets
    security_groups = [aws_security_group.db_sg.id]
    assign_public_ip = false
  }
}

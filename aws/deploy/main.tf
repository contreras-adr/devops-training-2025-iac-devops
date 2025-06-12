
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

  tags = {
    Project = "ECS-Demo"
  }
}
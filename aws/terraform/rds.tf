
resource "aws_db_subnet_group" "db" {
  count = var.use_rds ? 1 : 0
  name       = "db-subnet-group"
  subnet_ids = module.vpc.private_subnets
}

resource "aws_db_instance" "postgres" {
  count = var.use_rds ? 1 : 0
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "15.3"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "adminpass123"
  parameter_group_name = "default.postgres15"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.db[0].name

  tags = {
    "Project"     = "aws-terraform-iac"
    "Owner"       = "devops-training-2025"
    "Environment" = "dev"
    "CostCenter"  = "training-2025"
  }
}

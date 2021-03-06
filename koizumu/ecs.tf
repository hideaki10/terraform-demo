resource "aws_ecs_cluster" "example_ecs" {
  name = "example_ecs"
}

resource "aws_ecs_task_definition" "example_task" {
  family                   = "example_task"
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./container_definitions.json")
}

resource "aws_ecs_service" "example_ecs_service" {
  name                              = "example_ecs_service"
  cluster                           = aws_ecs_cluster.example_ecs.arn
  task_definition                   = aws_ecs_task_definition.example_task.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                   = "1.3.0"
  
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups  = [module.nginx_sg.security_group_id]

    subnets = [
      aws_subnet.example_private_subnet_0.id,
      aws_subnet.example_private_subnet_1.id,
    ]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.example_target_group.arn
    container_name   = "example"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}

module "nginx_sg" {
  source = "./security_groups"
  name        = "nginx-sg"
  vpc_id      = aws_vpc.example_vpc.id
  port        = 80
  cidr_blocks = [aws_vpc.example_vpc.cidr_block]
}
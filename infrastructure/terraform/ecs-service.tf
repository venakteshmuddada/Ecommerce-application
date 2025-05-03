# ECS Task Definition and Service for Frontend
resource "aws_ecs_task_definition" "frontend_task" {
  family                   = "frontend-task"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.ecs_task_execution.arn
  container_definitions   = jsonencode([
    {
      name      = "frontend"
      image     = "${aws_ecr_repository.frontend_repo.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol       = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "frontend_service" {
  name            = "ecommerce-frontend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets         = [data.aws_subnet.public1.id, data.aws_subnet.public2.id]
    security_groups = [aws_security_group.alb_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    container_name   = "frontend"
    container_port   = 80
  }

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  force_new_deployment = true

  depends_on = [aws_lb_listener.frontend_listener]
}

# ECS Task Definition and Service for Backend
resource "aws_ecs_task_definition" "backend_task" {
  family                   = "backend-task"
  network_mode            = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = "256"
  memory                  = "512"
  execution_role_arn      = aws_iam_role.ecs_task_execution.arn
  container_definitions   = jsonencode([
    {
      name      = "backend"
      image     = "${aws_ecr_repository.backend_repo.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          protocol       = "tcp"
        }
      ],
      environment = [
        { name = "DB_HOST", value = aws_db_instance.ecommerce_db.address },
        { name = "DB_USER", value = "admin" },
        { name = "DB_PASSWORD", value = "YourSecurePassword123" },
        { name = "DB_NAME", value = "ecommercedb" }
      ]
    }
  ])
}

resource "aws_ecs_service" "backend_service" {
  name            = "ecommerce-backend-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend_task.arn
  launch_type     = "FARGATE"
  desired_count   = 1

}
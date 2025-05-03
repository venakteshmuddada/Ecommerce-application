resource "aws_ecs_cluster" "main" {
  name = "ecommerce-cluster"
}

resource "aws_lb" "ecs_alb" {
  name               = "ecommerce-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [data.aws_subnet.public1.id, data.aws_subnet.public2.id]
  security_groups    = [aws_security_group.alb_sg.id]
}

resource "aws_lb_listener" "frontend_test_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 9000
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

resource "aws_lb_target_group" "frontend_tg_green" {
  name     = "frontend-tg-green"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected.id
  target_type = "ip"
}


resource "aws_security_group" "alb_sg" {
  name   = "alb-sg"
  vpc_id = data.aws_vpc.selected.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "frontend_tg" {
  name        = "frontend-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.selected.id
  target_type = "ip"
}

resource "aws_lb_listener" "frontend_listener" {
  load_balancer_arn = aws_lb.ecs_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

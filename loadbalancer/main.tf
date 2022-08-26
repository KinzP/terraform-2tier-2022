# loadbalancer/main.tf 

resource "aws_lb" "KP21_lb" {
  name = "KP21-lb"
  load_balancer_type = "application"
  subnets = var.public_subnets
  security_groups = [var.public_sg]
  idle_timeout = 400
}


resource "aws_lb_target_group" "KP21_lbtg" {
  name        = "KP21-tg"
  target_type = "alb"
  port        = var.tg_port 
  protocol    = var.tg_protocol 
  vpc_id      = var.vpc_id
  health_check {
    healthy_threshold = var.lb_healthy_threshold 
    unhealthy_threshold = var.lb_unhealthy_threshold 
    timeout = var.lb_timeout 
    interval = var.lb_interval 
  }
}


resource "aws_lb_listener" "KP21_lb_listner" {
  load_balancer_arn = aws_lb.KP21_lb.arn
  port = var.listener_port 
  protocol = var.listener_protocol 
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.KP21_lbtg.arn
  }
}
#loadbalancer/output.tf 

output "lb_target_group_arn" {
  value = aws_lb_target_group.KP21_lbtg.arn
}

output "lb_endpoint" {
  value = aws_lb.KP21_lb.dns_name
}
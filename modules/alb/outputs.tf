# Needed by Compute module for ASG attachment 
output "target_group_arn" {
  value = aws_lb_target_group.this.arn
}

# Used to allow traffic from ALB → EC2
output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

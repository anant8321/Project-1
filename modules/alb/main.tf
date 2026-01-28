
resource "aws_security_group" "alb_sg" {
  name = "${var.project_name}-alb-sg"
  vpc_id = "${var.vpc_id}"

  ingress {           # inbound rule for alb
   from_port = 80
   to_port = 80 
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
  egress {        # outbound
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "this" {
  name = "${var.project_name}-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = var.public_sub_ids
}

resource "aws_lb_target_group" "this" {
  name = "${var.project_name}-alb-tg"
  port = var.app_port
  protocol = "HTTP"
  vpc_id = var.vpc_id

  # can this one EC2(already created) serve traffic ?
  health_check {
    path = "/"
    port = var.app_port   # ALB checks EC2 on backend port (8080)
    protocol = "HTTP"
    interval = 30             # ALB checks every 30 seconds
    timeout = 5         # Wait 5 seconds for response, No response → failure
    healthy_threshold = 2   # Needs 2 consecutive successes to mark healthy
    unhealthy_threshold = 2 # Needs 2 consecutive failures to mark unhealthy
    matcher = "200"             # expected HTTP status code for healthy
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port = 80               # ALB Accept HTTP traffic on port 80
  protocol = "HTTP"

  default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.this.arn
    }    
}
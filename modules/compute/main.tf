
# Security group for ec2
resource "aws_security_group" "ec2-sg" {
  name = "${var.project_name}-ec2-sg"
  vpc_id = "${var.vpc_id}"

        # only alb's incoming traffic is allowed 
  ingress {
    from_port = var.app_port    # range - from
    to_port = var.app_port      # range - to
    protocol = "tcp"
    security_groups = [var.alb_security_group_id]
  }
  egress {
    from_port = 0           # no meaning as 'all traffic'
    to_port = 0
    protocol = "-1"     # all traffic
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}

#  Launch Template (EC2 Blueprint)
resource "aws_launch_template" "this" {
  name_prefix = "${var.project_name}-lt-"
  image_id = var.ami_id
  instance_type = var.instance_type
  # we using SSM instead of SSH -> no need for key-pair

  iam_instance_profile {
    # EC2 can assume IAM role via instance profile below :
    name = var.instance_profile_name
  }

  network_interfaces {
    # no public IP assignment to any EC2
    associate_public_ip_address = false     
    security_groups = [aws_security_group.ec2-sg.id]
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    APP_PORT_NO = var.app_port
  }))
}

resource "aws_autoscaling_group" "this" {
  name = "${var.project_name}-asg"
  
  desired_capacity = var.desired_capacity
  min_size = var.min_size
  max_size = var.max_size

  vpc_zone_identifier = var.private_subnet_ids

  launch_template {
    id = aws_launch_template.this.id
    version = "$Latest"
  }

# EC2s are automatically added/removed from ALB target group by :-
  target_group_arns = [var.target_group_arn]

  health_check_type = "ELB"
  health_check_grace_period = 300
}


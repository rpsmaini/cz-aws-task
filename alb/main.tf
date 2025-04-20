resource "aws_security_group" "cz-alb-sg" {
    name          = "cz-alb-sg"
    vpc_id        = var.vpc-id
    description   = "Allow http/s traffic on node serverport" 
  # Allow inbound traffic
  
  ingress {
    from_port   = 80      # HTTP port
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTP from anywhere
  }

  ingress {
    from_port   = 443      # HTTPS port
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow HTTPS from anywhere
  }
  # Allow outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # All protocols
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic
  }

  tags = {
    Name = "cz-alb-sg"
  }
}

resource "aws_lb" "cz-alb" {
  tags = {
    name = "cz-alb"
    }

    name = "cz-alb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.cz-alb-sg.id]
    subnets = var.vpc_public_subnets 
}

resource "aws_lb_target_group" "cz-alb-tg" {
  tags = {
    name = "cz-alb-tg"
    }

    name = "cz-alb-tg"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc-id
}

resource "aws_autoscaling_attachment" "cz-asg-attachment" {
    autoscaling_group_name = var.asg-id
    lb_target_group_arn = aws_lb_target_group.cz-alb-tg.arn
}

resource "aws_lb_listener" "cz-alb-listner" {
  load_balancer_arn = aws_lb.cz-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cz-alb-tg.arn
  }
}

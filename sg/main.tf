# Create a security group

resource "aws_security_group" "node-app-sg" {
    name          = "node-app-sg"
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
    Name = "node-app-sg"
  }
}

resource "aws_security_group" "cz-jump-sg" {
  name        = "cz-jump-sg"
  vpc_id        = var.vpc-id
  description = "Allow http/s traffic on node serverport" 
  # Allow inbound traffic
  
  ingress {
    from_port   = 22     # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow ssh from anywhere
  }

  # Allow outbound traffic
  egress {
    from_port   = 22     # SSH port
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow ssh from anywhere
  }

  tags = {
    Name = "cz-jump-sg"
  }
}


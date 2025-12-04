terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# VPC
resource "aws_vpc" "yash_uppal_vpc_task3" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Yash_Uppal_VPC_Task3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "yash_uppal_igw_task3" {
  vpc_id = aws_vpc.yash_uppal_vpc_task3.id

  tags = {
    Name = "Yash_Uppal_IGW_Task3"
  }
}

# Public Subnets for ALB
resource "aws_subnet" "yash_uppal_public_subnet_1_task3" {
  vpc_id                  = aws_vpc.yash_uppal_vpc_task3.id
  cidr_block              = "10.2.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Yash_Uppal_Public_Subnet_1_Task3"
  }
}

resource "aws_subnet" "yash_uppal_public_subnet_2_task3" {
  vpc_id                  = aws_vpc.yash_uppal_vpc_task3.id
  cidr_block              = "10.2.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Yash_Uppal_Public_Subnet_2_Task3"
  }
}

# Private Subnets for EC2 Instances
resource "aws_subnet" "yash_uppal_private_subnet_1_task3" {
  vpc_id            = aws_vpc.yash_uppal_vpc_task3.id
  cidr_block        = "10.2.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Yash_Uppal_Private_Subnet_1_Task3"
  }
}

resource "aws_subnet" "yash_uppal_private_subnet_2_task3" {
  vpc_id            = aws_vpc.yash_uppal_vpc_task3.id
  cidr_block        = "10.2.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "Yash_Uppal_Private_Subnet_2_Task3"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "yash_uppal_nat_eip_task3" {
  domain = "vpc"

  tags = {
    Name = "Yash_Uppal_NAT_EIP_Task3"
  }

  depends_on = [aws_internet_gateway.yash_uppal_igw_task3]
}

# NAT Gateway
resource "aws_nat_gateway" "yash_uppal_nat_gateway_task3" {
  allocation_id = aws_eip.yash_uppal_nat_eip_task3.id
  subnet_id     = aws_subnet.yash_uppal_public_subnet_1_task3.id

  tags = {
    Name = "Yash_Uppal_NAT_Gateway_Task3"
  }

  depends_on = [aws_internet_gateway.yash_uppal_igw_task3]
}

# Public Route Table
resource "aws_route_table" "yash_uppal_public_rt_task3" {
  vpc_id = aws_vpc.yash_uppal_vpc_task3.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yash_uppal_igw_task3.id
  }

  tags = {
    Name = "Yash_Uppal_Public_RT_Task3"
  }
}

resource "aws_route_table_association" "yash_uppal_public_subnet_1_association_task3" {
  subnet_id      = aws_subnet.yash_uppal_public_subnet_1_task3.id
  route_table_id = aws_route_table.yash_uppal_public_rt_task3.id
}

resource "aws_route_table_association" "yash_uppal_public_subnet_2_association_task3" {
  subnet_id      = aws_subnet.yash_uppal_public_subnet_2_task3.id
  route_table_id = aws_route_table.yash_uppal_public_rt_task3.id
}

# Private Route Table
resource "aws_route_table" "yash_uppal_private_rt_task3" {
  vpc_id = aws_vpc.yash_uppal_vpc_task3.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.yash_uppal_nat_gateway_task3.id
  }

  tags = {
    Name = "Yash_Uppal_Private_RT_Task3"
  }
}

resource "aws_route_table_association" "yash_uppal_private_subnet_1_association_task3" {
  subnet_id      = aws_subnet.yash_uppal_private_subnet_1_task3.id
  route_table_id = aws_route_table.yash_uppal_private_rt_task3.id
}

resource "aws_route_table_association" "yash_uppal_private_subnet_2_association_task3" {
  subnet_id      = aws_subnet.yash_uppal_private_subnet_2_task3.id
  route_table_id = aws_route_table.yash_uppal_private_rt_task3.id
}

# Security Group for ALB
resource "aws_security_group" "yash_uppal_alb_sg_task3" {
  name        = "Yash_Uppal_ALB_SG_Task3"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.yash_uppal_vpc_task3.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Yash_Uppal_ALB_SG_Task3"
  }
}

# Security Group for EC2 (Private)
resource "aws_security_group" "yash_uppal_ec2_sg_task3" {
  name        = "Yash_Uppal_EC2_SG_Task3"
  description = "Security group for EC2 in private subnets"
  vpc_id      = aws_vpc.yash_uppal_vpc_task3.id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.yash_uppal_alb_sg_task3.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.yash_uppal_alb_sg_task3.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Yash_Uppal_EC2_SG_Task3"
  }
}

# Application Load Balancer
resource "aws_lb" "yash_uppal_alb_task3" {
  name               = "yash-uppal-alb-task3"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.yash_uppal_alb_sg_task3.id]
  subnets            = [aws_subnet.yash_uppal_public_subnet_1_task3.id, aws_subnet.yash_uppal_public_subnet_2_task3.id]

  enable_deletion_protection = false

  tags = {
    Name = "Yash_Uppal_ALB_Task3"
  }
}

# Target Group
resource "aws_lb_target_group" "yash_uppal_tg_task3" {
  name        = "yash-uppal-tg-task3"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.yash_uppal_vpc_task3.id
  target_type = "instance"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    path                = "/"
    matcher             = "200"
  }

  tags = {
    Name = "Yash_Uppal_TG_Task3"
  }
}

# ALB Listener
resource "aws_lb_listener" "yash_uppal_listener_task3" {
  load_balancer_arn = aws_lb.yash_uppal_alb_task3.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.yash_uppal_tg_task3.arn
  }
}

# Launch Template
resource "aws_launch_template" "yash_uppal_lt_task3" {
  name_prefix   = "yash-uppal-lt-"
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.yash_uppal_ec2_sg_task3.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              
              # Create a simple resume page
              cat > /var/www/html/index.html <<'RESUME'
              <!DOCTYPE html>
              <html>
              <head>
                  <title>Yash Uppal - Resume</title>
                  <style>
                      body { font-family: Arial; margin: 40px; background: #f4f4f4; }
                      .container { background: white; padding: 20px; border-radius: 8px; }
                      h1 { color: #007bff; }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>Yash Uppal</h1>
                      <p>BTech CSE Student | Full Stack Developer</p>
                      <p>Hosted on AWS EC2 with Auto Scaling</p>
                      <p>Instance ID: $(curl http://169.254.169.254/latest/meta-data/instance-id)</p>
                  </div>
              </body>
              </html>
              RESUME
              
              chown -R www-data:www-data /var/www/html
              chmod -R 755 /var/www/html
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Yash_Uppal_Instance_Task3"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "yash_uppal_asg_task3" {
  name                = "yash-uppal-asg-task3"
  vpc_zone_identifier = [aws_subnet.yash_uppal_private_subnet_1_task3.id, aws_subnet.yash_uppal_private_subnet_2_task3.id]
  target_group_arns   = [aws_lb_target_group.yash_uppal_tg_task3.arn]
  health_check_type   = "ELB"
  health_check_grace_period = 300

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  launch_template {
    id      = aws_launch_template.yash_uppal_lt_task3.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "Yash_Uppal_ASG_Instance_Task3"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Outputs
output "alb_dns_name" {
  value       = aws_lb.yash_uppal_alb_task3.dns_name
  description = "DNS name of the load balancer"
}

output "alb_url" {
  value       = "http://${aws_lb.yash_uppal_alb_task3.dns_name}"
  description = "URL to access the website through ALB"
}

output "asg_name" {
  value = aws_autoscaling_group.yash_uppal_asg_task3.name
}

output "target_group_arn" {
  value = aws_lb_target_group.yash_uppal_tg_task3.arn
}

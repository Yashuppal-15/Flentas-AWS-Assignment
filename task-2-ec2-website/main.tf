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

# Reference the VPC from task-1 (you'll update this after task-1 is deployed)
resource "aws_vpc" "yash_uppal_vpc_task2" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Yash_Uppal_VPC_Task2"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "yash_uppal_igw_task2" {
  vpc_id = aws_vpc.yash_uppal_vpc_task2.id

  tags = {
    Name = "Yash_Uppal_IGW_Task2"
  }
}

# Public Subnet
resource "aws_subnet" "yash_uppal_public_subnet_task2" {
  vpc_id                  = aws_vpc.yash_uppal_vpc_task2.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Yash_Uppal_Public_Subnet_Task2"
  }
}

# Public Route Table
resource "aws_route_table" "yash_uppal_public_rt_task2" {
  vpc_id = aws_vpc.yash_uppal_vpc_task2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.yash_uppal_igw_task2.id
  }

  tags = {
    Name = "Yash_Uppal_Public_RT_Task2"
  }
}

resource "aws_route_table_association" "yash_uppal_subnet_association_task2" {
  subnet_id      = aws_subnet.yash_uppal_public_subnet_task2.id
  route_table_id = aws_route_table.yash_uppal_public_rt_task2.id
}

# Security Group for EC2
resource "aws_security_group" "yash_uppal_sg_task2" {
  name        = "Yash_Uppal_SG_Task2"
  description = "Security group for EC2 with Nginx"
  vpc_id      = aws_vpc.yash_uppal_vpc_task2.id

  # Allow HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH (only from your IP for security)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Yash_Uppal_SG_Task2"
  }
}

# EC2 Instance with Nginx and Resume
resource "aws_instance" "yash_uppal_ec2_task2" {
  ami                    = "ami-02b8269d5e85954ef"  # Ubuntu 20.04 LTS in ap-south-1
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.yash_uppal_public_subnet_task2.id
  vpc_security_group_ids = [aws_security_group.yash_uppal_sg_task2.id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              set -e
              
              # Update system
              apt-get update
              apt-get install -y nginx
              
              # Start Nginx
              systemctl start nginx
              systemctl enable nginx
              
              # Create resume HTML
              cat > /var/www/html/index.html <<'RESUME'
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>Yash Uppal - Resume</title>
                  <style>
                      body {
                          font-family: Arial, sans-serif;
                          line-height: 1.6;
                          max-width: 900px;
                          margin: 0 auto;
                          padding: 20px;
                          background-color: #f4f4f4;
                      }
                      .container {
                          background-color: white;
                          padding: 40px;
                          border-radius: 8px;
                          box-shadow: 0 0 10px rgba(0,0,0,0.1);
                      }
                      h1 {
                          color: #333;
                          border-bottom: 3px solid #007bff;
                          padding-bottom: 10px;
                      }
                      h2 {
                          color: #007bff;
                          margin-top: 30px;
                      }
                      .section {
                          margin-bottom: 20px;
                      }
                      .job-title {
                          font-weight: bold;
                          color: #333;
                      }
                      .company {
                          color: #666;
                          font-style: italic;
                      }
                      ul {
                          margin: 10px 0;
                          padding-left: 20px;
                      }
                      .tech-stack {
                          background-color: #f0f0f0;
                          padding: 10px;
                          border-radius: 4px;
                          margin: 10px 0;
                      }
                  </style>
              </head>
              <body>
                  <div class="container">
                      <h1>Yash Uppal</h1>
                      <p><strong>Email:</strong> yash.uppal@example.com | <strong>Phone:</strong> +91-XXXXXXXXXX</p>
                      <p><strong>Location:</strong> Kanpur, Uttar Pradesh, India</p>
                      
                      <h2>Professional Summary</h2>
                      <div class="section">
                          <p>BTech Computer Science final year student with expertise in full-stack web development. Proficient in JavaScript/TypeScript ecosystems with hands-on experience in React, Node.js, and cloud deployment. Passionate about building scalable applications and learning AWS infrastructure.</p>
                      </div>
                      
                      <h2>Technical Skills</h2>
                      <div class="section">
                          <div class="tech-stack">
                              <strong>Languages:</strong> JavaScript, TypeScript, Python, C++, Java, SQL<br>
                              <strong>Frontend:</strong> React, React Router, Tailwind CSS, HTML5, CSS3<br>
                              <strong>Backend:</strong> Node.js, Express.js, REST APIs<br>
                              <strong>Databases:</strong> PostgreSQL, MongoDB, Prisma ORM<br>
                              <strong>DevOps & Cloud:</strong> AWS, Docker, Git, GitHub, Vercel, Render<br>
                              <strong>Mobile:</strong> React Native, Flutter/Dart
                          </div>
                      </div>
                      
                      <h2>Projects</h2>
                      <div class="section">
                          <div class="job-title">Job Scheduler Automation</div>
                          <p>Automated job scheduling system using Node.js and PostgreSQL</p>
                          
                          <div class="job-title">SecureNotes Web Application</div>
                          <p>Full-stack note-taking app with encryption and user authentication</p>
                          
                          <div class="job-title">Finance Tracker</div>
                          <p>Flutter-based mobile application for expense tracking</p>
                      </div>
                      
                      <h2>Education</h2>
                      <div class="section">
                          <div class="job-title">BTech in Computer Science</div>
                          <p class="company">Current Year - Final Year</p>
                      </div>
                      
                      <h2>Certifications & Achievements</h2>
                      <div class="section">
                          <ul>
                              <li>AWS Placement Assignment - Flentas Technologies</li>
                              <li>Multiple project deployments on Vercel and Render</li>
                          </ul>
                      </div>
                  </div>
              </body>
              </html>
              RESUME
              
              # Set proper permissions
              chown -R www-data:www-data /var/www/html
              chmod -R 755 /var/www/html
              EOF
  )

  associate_public_ip_address = true

  tags = {
    Name = "Yash_Uppal_EC2_Task2"
  }
}

# Outputs
output "instance_id" {
  value = aws_instance.yash_uppal_ec2_task2.id
}

output "instance_public_ip" {
  value = aws_instance.yash_uppal_ec2_task2.public_ip
}

output "website_url" {
  value = "http://${aws_instance.yash_uppal_ec2_task2.public_ip}"
}

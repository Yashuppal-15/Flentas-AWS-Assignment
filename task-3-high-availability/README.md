# Task 3: High Availability + Auto Scaling

## HA Architecture & Traffic Flow Explanation

The architecture implements a highly available, scalable design following AWS best practices for production workloads. Traffic flows from the internet through the **Internet-facing Application Load Balancer (ALB)** in public subnets across two availability zones (ap-south-1a and ap-south-1b). The ALB distributes incoming requests to EC2 instances running in **private subnets** via a target group with health checks. The **Auto Scaling Group (ASG)** manages EC2 instances across multiple AZs, maintaining a minimum of 2 and maximum of 4 instances based on demand. Private subnets ensure instances are protected from direct internet access, accessing the internet only through the NAT Gateway for updates. This design ensures:

- **High Availability**: Multi-AZ deployment with automatic failover
- **Auto Scaling**: Instances scale based on demand
- **Security**: EC2 instances in private subnets, isolated from internet
- **Load Distribution**: ALB evenly distributes traffic across healthy instances
- **Health Monitoring**: ELB health checks ensure only healthy instances receive traffic

## Architecture Components

| Component | Purpose | Details |
|-----------|---------|---------|
| **ALB** | Load Balancing | Distributes traffic across instances in private subnets |
| **Target Group** | Health Management | Health checks every 30 seconds, 2 healthy/unhealthy threshold |
| **Auto Scaling Group** | Dynamic Scaling | Min: 2, Max: 4, Desired: 2 instances across 2 AZs |
| **Launch Template** | Instance Configuration | Defines AMI, instance type, security group, user data |
| **Private Subnets** | Security | EC2 instances run here, NAT Gateway for outbound access |
| **NAT Gateway** | Outbound Internet | Allows private instances to download updates safely |

## Routing Flow

1. **Internet User** → Requests ALB DNS name (http://alb-dns-name)
2. **ALB (Public Subnets)** → Receives request on port 80
3. **Target Group** → Performs health check on /
4. **ASG (Private Subnets)** → Routes to healthy EC2 instances
5. **Nginx on EC2** → Serves resume website
6. **Response** → Returns to user through ALB

## Screenshots (To be added after deployment)

- ALB Configuration details
- Target Group with health check settings
- Auto Scaling Group configuration
- EC2 Instances launched by ASG in private subnets
- ALB DNS working in browser

## Terraform Code

See `main.tf` for complete infrastructure-as-code implementation with:
- Multi-AZ VPC with public and private subnets
- NAT Gateway for secure outbound access
- ALB with listener and target group
- Launch template with Nginx auto-installation
- Auto Scaling Group spanning 2 AZs

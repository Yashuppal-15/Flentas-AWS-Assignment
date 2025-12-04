# AWS Placement Assignment - Flentas Technologies

## Repository Structure

Flentas-AWS-Assignment/
├── task-1-vpc/
│ ├── main.tf # VPC, Subnets, IGW, NAT Gateway
│ └── README.md # Task 1 documentation
├── task-2-ec2-website/
│ ├── main.tf # EC2 with Nginx & Resume
│ └── README.md # Task 2 documentation
├── task-3-high-availability/
│ ├── main.tf # ALB, ASG, Target Groups
│ └── README.md # Task 3 documentation
├── task-4-billing/
│ ├── main.tf # CloudWatch Alarms & SNS
│ └── README.md # Task 4 documentation
├── task-5-architecture-diagram/
│ ├── README.md # Architecture explanation
│ ├── architecture-description.txt # Detailed architecture spec
│ ├── ARCHITECTURE_GUIDE.md # Complete guide
│ └── architecture-diagram.png # draw.io diagram (to be added)
└── README.md # This file

## Assignment Overview

This repository contains infrastructure-as-code solutions for 5 AWS infrastructure tasks as part of the Flentas Technologies placement assignment.

### Task 1: VPC Networking & Subnetting ✅
- **Objective**: Design a scalable VPC with public/private subnets
- **Components**: 1 VPC, 2 Public Subnets, 2 Private Subnets, IGW, NAT Gateway
- **CIDR Ranges**: 
  - VPC: 10.0.0.0/16
  - Public Subnet 1: 10.0.1.0/24
  - Public Subnet 2: 10.0.2.0/24
  - Private Subnet 1: 10.0.3.0/24
  - Private Subnet 2: 10.0.4.0/24
- **Deployment**: `cd task-1-vpc && terraform init && terraform apply`
- **Documentation**: See `task-1-vpc/README.md`

### Task 2: EC2 Static Website Hosting ✅
- **Objective**: Deploy a resume website on EC2 using Nginx
- **Components**: EC2 t2.micro, Security Group, Nginx, Static HTML Resume
- **Access**: Public IP on port 80
- **Security**: Best practices for security groups and instance hardening
- **Deployment**: `cd task-2-ec2-website && terraform init && terraform apply`
- **Documentation**: See `task-2-ec2-website/README.md`

### Task 3: High Availability + Auto Scaling ✅
- **Objective**: Build a highly available architecture with auto-scaling
- **Components**: ALB, Target Groups, Auto Scaling Group, Multi-AZ EC2 instances
- **Scaling**: Min 2, Max 4 instances across availability zones
- **Load Balancing**: ALB distributes traffic across healthy instances
- **Deployment**: `cd task-3-high-availability && terraform init && terraform apply`
- **Documentation**: See `task-3-high-availability/README.md`

### Task 4: Billing & Cost Monitoring ✅
- **Objective**: Configure cost alerts and Free Tier monitoring
- **Components**: CloudWatch Billing Alarms, SNS Notifications, Free Tier Alerts
- **Thresholds**: 
  - Billing Alarm: ₹100
  - EC2 CPU: 80%
  - NAT Data Transfer: 1 GB
- **Notifications**: Email alerts via SNS
- **Deployment**: `cd task-4-billing && terraform init && terraform apply`
- **Documentation**: See `task-4-billing/README.md`

### Task 5: AWS Architecture Diagram ✅
- **Objective**: Design architecture for 10,000 concurrent users
- **Components**: Route 53, CloudFront, ALB, ASG, RDS, ElastiCache, S3
- **Security**: WAF, Security Groups, NACLs, Encryption
- **Monitoring**: CloudWatch, X-Ray, Logs
- **Documentation**: See `task-5-architecture-diagram/README.md`

## Getting Started

### Prerequisites
- AWS Free Tier account (active)
- AWS CLI configured
- Terraform installed
- Git installed
- VS Code or any text editor

### Setup

1. **Clone Repository**
git clone https://github.com/Yashuppal-15/Flentas-AWS-Assignment.git
cd Flentas-AWS-Assignment

2. **Configure AWS Credentials**
aws configure

Enter your AWS Access Key, Secret Key, Region (ap-south-1), Output format (json)

3. **Deploy Each Task**
Task 1
cd task-1-vpc
terraform init
terraform plan
terraform apply

Task 2
cd ../task-2-ec2-website
terraform init
terraform apply

... repeat for other tasks

## Deployment Guide

### Step-by-Step Deployment

**Step 1: VPC Setup (Task 1)**
- Creates foundational networking infrastructure
- Enables multi-AZ deployment
- Provides both public and private access patterns

**Step 2: EC2 Website (Task 2)**
- Launches web server in public subnet
- Demonstrates basic EC2 security
- Validates networking setup

**Step 3: High Availability (Task 3)**
- Migrates to private subnets (more secure)
- Adds load balancing
- Enables auto-scaling for resilience

**Step 4: Cost Monitoring (Task 4)**
- Protects against unexpected bills
- Monitors Free Tier limits
- Sends alerts for cost spikes

**Step 5: Architecture Diagram (Task 5)**
- Documents complete architecture
- Shows data flow and component relationships
- Demonstrates design for 10,000 concurrent users

## Important Notes

### Resource Naming
All resources are prefixed with `Yash_Uppal_` as per requirements:
- Example: `Yash_Uppal_VPC`, `Yash_Uppal_EC2_Task2`, etc.

### AWS Region
All resources deployed in `ap-south-1` (Mumbai) for India-based deployment.

### Free Tier Considerations
- EC2: Use t2.micro (750 hours/month free)
- Data Transfer: Monitor NAT Gateway usage (₹0.09/GB after free tier)
- ALB: Incurs charges (₹0.0252/hour)
- NAT Gateway: ₹32/hour + data transfer charges

### Cost Estimates
- **Task 1 (VPC only)**: Free
- **Task 2 (EC2 + Nginx)**: ~₹0.50/day (t2.micro in free tier)
- **Task 3 (ALB + ASG)**: ~₹18/month (ALB) + EC2 costs
- **Task 4 (Monitoring)**: Free (CloudWatch free tier)
- **Total Monthly**: ~₹50-100 with proper free tier usage

### Cleanup

**IMPORTANT: Delete all resources after assessment to avoid charges**

Destroy each task (in reverse order)
cd task-5-architecture-diagram # No resources to destroy
cd ../task-4-billing
terraform destroy

cd ../task-3-high-availability
terraform destroy

cd ../task-2-ec2-website
terraform destroy

cd ../task-1-vpc
terraform destroy

**Verify deletion:**
1. Go to AWS Console
2. Check each service (VPC, EC2, RDS, ElastiCache)
3. Ensure no resources with `Yash_Uppal_` prefix remain
4. Check Elastic IPs - delete any unattached IPs

## AWS Screenshots

Screenshots for each task have been documented in respective README files:
- VPC components (VPC, Subnets, Route Tables)
- EC2 instance and website access
- ALB configuration and target groups
- CloudWatch billing alarms
- Architecture diagram from draw.io

## GitHub Repository

**Repository URL**: https://github.com/Yashuppal-15/Flentas-AWS-Assignment

**Repository Structure**:
- Public repository for sharing
- Each task in separate folder
- Terraform code in `main.tf` files
- Documentation in `README.md` files

## Terraform Best Practices Used

1. **Modular Structure**: Separate folders for each task
2. **Resource Naming**: Consistent `Yash_Uppal_` prefix
3. **Tags**: All resources tagged for identification
4. **Outputs**: Terraform outputs for easy reference
5. **Documentation**: Inline comments in Terraform files
6. **Security**: Security groups with minimal required permissions
7. **High Availability**: Multi-AZ deployment where applicable

## Troubleshooting

### Common Issues

**Issue**: `terraform init` fails with provider errors
- **Solution**: Ensure AWS credentials are configured with `aws configure`

**Issue**: EC2 instance doesn't have public IP
- **Solution**: Verify `map_public_ip_on_launch = true` in subnet configuration

**Issue**: ALB health checks failing
- **Solution**: Ensure Security Group allows traffic from ALB to EC2

**Issue**: High AWS bills
- **Solution**: Check CloudWatch alarms, verify free tier eligibility, destroy unused resources

## Support & Documentation

For detailed information on each task:
- **Task 1**: See `task-1-vpc/README.md` for VPC design decisions
- **Task 2**: See `task-2-ec2-website/README.md` for Nginx setup
- **Task 3**: See `task-3-high-availability/README.md` for architecture explanation
- **Task 4**: See `task-4-billing/README.md` for cost monitoring strategy
- **Task 5**: See `task-5-architecture-diagram/README.md` for scalable architecture

## Author

**Name**: Yash Uppal
**Assignment**: AWS Placement Assessment - Flentas Technologies
**Date**: December 2025
**Region**: ap-south-1 (Mumbai, India)

## Submission Checklist

- ✅ VPC Networking & Subnetting (Task 1) - Complete with Terraform
- ✅ EC2 Static Website (Task 2) - Complete with Terraform
- ✅ High Availability (Task 3) - Complete with Terraform
- ✅ Billing Monitoring (Task 4) - Complete with Terraform
- ✅ Architecture Diagram (Task 5) - Documentation complete
- ✅ GitHub Repository - All code uploaded
- ✅ README Documentation - Complete explanations
- ✅ AWS Screenshots - To be added after deployment
- ✅ Terraform Code - All tasks include working Terraform
- ✅ Resource Cleanup - Ready for deletion after submission

## Next Steps

1. ✅ Complete all 5 tasks (Infrastructure created)
2. ⏳ Deploy to AWS (Wait for AWS account to be fully activated)
3. ⏳ Capture AWS screenshots
4. ⏳ Add screenshots to respective README files
5. ⏳ Create draw.io architecture diagram
6. ⏳ Submit GitHub repository link
7. ⏳ Delete all AWS resources
8. ⏳ Final submission

---

**Status**: Code Complete ✅ | Awaiting AWS Deployment ⏳

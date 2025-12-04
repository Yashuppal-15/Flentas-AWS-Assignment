# Task 1: AWS VPC Networking & Subnetting

## Approach Explanation

I designed a highly available VPC architecture following AWS best practices with multi-AZ deployment across two availability zones (ap-south-1a and ap-south-1b). The design separates public and private subnets to ensure security - public subnets host resources requiring internet access (IGW), while private subnets host backend resources with outbound-only internet access through a NAT Gateway. This architecture enables secure communication, automatic failover across availability zones, and proper traffic routing through public and private route tables with appropriate gateway associations.

## CIDR Ranges Used

| Resource | CIDR Range | Reason |
|----------|-----------|--------|
| VPC | 10.0.0.0/16 | Provides 65,536 IP addresses, allowing room for growth and multiple subnets. Standard private IP range. |
| Public Subnet 1 (ap-south-1a) | 10.0.1.0/24 | 256 IPs for public resources in AZ-1. Leaves room for additional public subnets. |
| Public Subnet 2 (ap-south-1b) | 10.0.2.0/24 | 256 IPs for public resources in AZ-2. Ensures high availability. |
| Private Subnet 1 (ap-south-1a) | 10.0.3.0/24 | 256 IPs for private resources in AZ-1. Protected from direct internet. |
| Private Subnet 2 (ap-south-1b) | 10.0.4.0/24 | 256 IPs for private resources in AZ-2. Ensures redundancy. |

## Key Components

- **VPC**: 10.0.0.0/16 - Main network container
- **Internet Gateway**: Enables public subnet resources to communicate with the internet
- **NAT Gateway**: Allows private subnet resources to access the internet for outbound connections only
- **Route Tables**: 
  - Public RT: Routes 0.0.0.0/0 to IGW
  - Private RT: Routes 0.0.0.0/0 to NAT Gateway
- **Multi-AZ Design**: Subnets spread across ap-south-1a and ap-south-1b for high availability

## Infrastructure Screenshots

[Screenshots to be added after AWS deployment]

## Terraform Code

See `main.tf` in this directory for the complete infrastructure-as-code implementation.

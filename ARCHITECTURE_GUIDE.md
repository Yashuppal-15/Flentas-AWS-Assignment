# AWS ARCHITECTURE SUMMARY - Task 5

## Quick Start

This document serves as the architecture specification for the draw.io diagram.

For the actual visual diagram, visit: https://draw.io/ and manually create using AWS icons following the structure below, or use the text description as reference.

## Architecture Overview for 10,000 Concurrent Users

### Layer 1: Global Edge
- Route 53 DNS (Geolocation routing)
- CloudFront CDN (Global edge caching)
- AWS Shield Standard (Automatic DDoS protection)
- AWS WAF (Application layer security)

### Layer 2: Ingress
- Application Load Balancer (ALB)
- Multi-AZ deployment (3 AZs)
- Listeners on Port 80/443
- Target Groups with health checks

### Layer 3: Compute
- Auto Scaling Group (2-20 instances)
- EC2 t3.medium/large instances
- Distributed across 3 AZs
- Launch Template with Nginx/Node.js

### Layer 4: Networking
- VPC: 10.0.0.0/16
- Public subnets: 10.0.1-3.0/24
- Private subnets: 10.0.4-6.0/24
- NAT Gateways (3x, one per AZ)
- Security Groups + NACLs

### Layer 5: Data
- RDS Aurora MySQL (Multi-AZ)
- ElastiCache Redis (Session + Cache)
- S3 (Static assets)
- All encrypted (KMS)

### Layer 6: Observability
- CloudWatch (Metrics, Logs, Alarms)
- X-Ray (Distributed tracing)
- SNS (Notifications)

### Layer 7: Security
- IAM Roles
- Secrets Manager
- KMS Encryption
- ACM Certificates
- VPC Flow Logs

## How to Create the Diagram in draw.io

1. **Top to Bottom Structure:**
   - Row 1: Route 53, CloudFront, AWS Shield, WAF
   - Row 2: ALB (center, pointing down)
   - Row 3: Target Group (center)
   - Row 4: ASG with EC2 instances (3 boxes for 3 AZs)
   - Row 5: RDS Aurora, ElastiCache, S3 (bottom layer)

2. **Color Coding:**
   - Blue: Networking (ALB, VPC, Subnets)
   - Green: Compute (EC2, ASG)
   - Orange: Database (RDS, ElastiCache)
   - Purple: Security (WAF, Security Groups)

3. **Arrows/Connections:**
   - User → Route 53 → CloudFront → WAF → ALB
   - ALB → Target Group → EC2 instances (3 arrows for 3 AZs)
   - EC2 → RDS Aurora
   - EC2 → ElastiCache
   - EC2 → S3
   - CloudWatch monitoring all layers

## Key Metrics & Thresholds

| Metric | Threshold | Action |
|--------|-----------|--------|
| CPU Utilization | >70% | Scale UP (+2) |
| CPU Utilization | <30% | Scale DOWN (-1) |
| Request Count | >10,000/min | Emergency scale |
| Response Time | >2s | Investigate, add capacity |
| Memory | >80% | Alert & investigate |

## Cost Breakdown (Monthly)

- EC2 (Reserved): $300-400
- RDS Aurora: $200-300
- ElastiCache: $50-80
- ALB: $16-20
- CloudFront: $800-1000
- Data Transfer: $50-100
- **Total**: ~₹1,400-1,900/month

## Deployment Sequence

1. Create VPC with subnets (Task 1)
2. Launch EC2 with Nginx (Task 2)
3. Create ALB + ASG (Task 3)
4. Configure monitoring (Task 4)
5. Create architecture diagram (Task 5)

## High Availability Features

- Multi-AZ deployment (3 AZs)
- Auto Scaling (automatic instance management)
- RDS Multi-AZ failover (automatic database failover)
- ElastiCache Multi-AZ (automatic cache failover)
- ALB health checks (automatic instance removal)
- Route 53 health checks (DNS failover)

## Security Best Practices Implemented

- Private subnets for EC2 (not exposed to internet)
- Security Groups (stateful firewall)
- NACLs (stateless firewall)
- WAF on ALB (SQL injection, XSS protection)
- Encryption in transit (SSL/TLS)
- Encryption at rest (KMS)
- Least-privilege IAM roles
- Secrets Manager for credentials
- VPC Flow Logs for audit

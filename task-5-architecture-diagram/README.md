# Task 5: AWS Architecture Diagram - Scalable Web Application (10,000 Concurrent Users)

## Architecture Explanation

This architecture is designed to handle 10,000 concurrent users with high availability, scalability, and security. Traffic enters through **Route 53** (DNS) and reaches the **CloudFront CDN** for global edge caching and DDoS protection via **AWS Shield**. The application layer uses an **Internet-facing Application Load Balancer (ALB)** in public subnets across 3 AZs, routing traffic to an **Auto Scaling Group** of EC2 instances in private subnets. Backend data is managed by **Amazon RDS (Aurora MySQL)** with Multi-AZ failover for durability, while **ElastiCache (Redis)** provides in-memory caching for session and frequently accessed data. Static assets are stored in **S3** served through CloudFront. Security is enforced via **Security Groups**, **NACLs**, and **AWS WAF** on the ALB. **CloudWatch** monitors all metrics (CPU, memory, disk), logs are centralized in **CloudWatch Logs**, and **X-Ray** traces distributed requests for debugging. **Auto Scaling** policies handle traffic spikes, scaling from 2 to 20+ instances as needed. NAT Gateways enable private instance updates, while **VPC Endpoints** reduce data transfer costs. This multi-layered approach ensures fault tolerance, performance, and cost optimization.

## Architecture Components

### 1. **Global Edge & Security**
- **Route 53**: DNS with geolocation routing and health checks
- **CloudFront**: CDN for global content delivery and caching
- **AWS Shield Standard**: DDoS protection (included)
- **AWS WAF**: Web Application Firewall on ALB for application-layer protection

### 2. **Load Balancing & Auto Scaling**
- **Application Load Balancer (ALB)**: Multi-AZ load balancing
- **Target Groups**: Health-checked instances, path-based routing
- **Auto Scaling Group**: Min 2, Max 20 instances across 3 AZs
- **EC2 Instances (t3.medium/large)**: Application servers

### 3. **Networking**
- **VPC**: 10.0.0.0/16 with multi-AZ subnets
- **Public Subnets**: ALB, NAT Gateways
- **Private Subnets**: EC2 instances
- **VPC Endpoints**: S3, DynamoDB for private access
- **Security Groups & NACLs**: Layered security

### 4. **Data Layer**
- **Amazon RDS (Aurora MySQL)**: Multi-AZ primary database
  - Automated backups with point-in-time recovery
  - Read replicas for scaling read operations
  - Encryption at rest and in transit
- **ElastiCache (Redis)**: Session store and cache layer
  - Multi-AZ cluster for high availability
  - Auto-failover enabled
- **Amazon S3**: Static assets, backups, logs storage
  - Versioning enabled
  - Lifecycle policies for cost optimization

### 5. **Observability & Logging**
- **CloudWatch Metrics**: CPU, memory, network monitoring
- **CloudWatch Logs**: Centralized application and system logs
- **CloudWatch Alarms**: Auto-scaling triggers and alerts
- **X-Ray**: Distributed tracing for request analysis
- **AWS Systems Manager Patch Manager**: Auto-patching

### 6. **Security & Compliance**
- **IAM Roles**: Least-privilege access for EC2, RDS, Lambda
- **Secrets Manager**: Store DB credentials, API keys
- **KMS Encryption**: Data encryption at rest
- **ACM Certificates**: SSL/TLS termination on ALB
- **VPC Flow Logs**: Network traffic analysis

### 7. **Cost Optimization**
- **Reserved Instances**: 30-40% savings on EC2
- **Savings Plans**: Flexible pricing for compute
- **S3 Intelligent-Tiering**: Automatic cost optimization
- **Spot Instances**: Non-critical batch jobs (optional)

## Traffic Flow

User Request
↓
Route 53 (DNS Resolution)
↓
CloudFront (CDN Cache - if static content)
↓
AWS WAF (Security screening)
↓
ALB (Port 80/443)
↓
Target Group Health Check
↓
Auto Scaling Group (2-20 EC2s across 3 AZs)
↓
Application Server (Nginx/Node.js)
↓
ElastiCache (Session cache hit? → Redis)
↓
RDS Aurora (Database query)
↓
S3 (Static assets via CloudFront)
↓
Response back to User

## Scaling Strategy for 10,000 Concurrent Users

| Metric | Threshold | Action |
|--------|-----------|--------|
| **CPU Utilization** | >70% | Scale up (+2 instances) |
| **CPU Utilization** | <30% | Scale down (-1 instance) |
| **Request Count** | >10,000/min | Trigger emergency scale to max 20 |
| **ALB Response Time** | >2s | Add instances, check cache |

## Cost Estimation (Monthly)

| Component | Estimated Cost |
|-----------|-----------------|
| EC2 (10 instances avg, t3.medium reserved) | $300-400 |
| RDS Aurora (db.t3.medium, Multi-AZ) | $200-300 |
| ElastiCache Redis (cache.t3.small) | $50-80 |
| ALB | $16-20 |
| CloudFront (100TB transfer) | $800-1000 |
| NAT Gateway (50GB transfer) | $22-30 |
| S3 (100GB storage + requests) | $20-30 |
| CloudWatch Logs (50GB ingestion) | $25-35 |
| **Total Estimated** | **~$1,400-1,900/month** |

## Diagram Components (draw.io)

Your architecture diagram should include:

1. ✅ Route 53 DNS
2. ✅ CloudFront CDN with AWS Shield
3. ✅ AWS WAF
4. ✅ Application Load Balancer (Multi-AZ)
5. ✅ Auto Scaling Group (EC2 instances across 3 AZs)
6. ✅ VPC with public/private subnets
7. ✅ NAT Gateways
8. ✅ RDS Aurora (Multi-AZ)
9. ✅ ElastiCache Redis
10. ✅ S3 Bucket
11. ✅ VPC Endpoints (S3, DynamoDB)
12. ✅ Security Groups & NACLs
13. ✅ CloudWatch & X-Ray monitoring
14. ✅ KMS Encryption symbols

## How to Create in draw.io

1. Go to https://draw.io/
2. Create new diagram
3. Use AWS icon library (left sidebar → Search "AWS")
4. Drag and drop components
5. Connect with arrows showing data flow
6. Add labels and descriptions
7. Export as PNG and upload to GitHub

## Files in This Directory

- `README.md` - This file with architecture explanation
- `architecture-diagram.png` - draw.io diagram export (to be added)
- `architecture-diagram.drawio` - draw.io editable file (optional)

## Next Steps

1. Create detailed draw.io diagram with all components
2. Export as high-resolution PNG
3. Add to GitHub repository
4. Reference in final submission

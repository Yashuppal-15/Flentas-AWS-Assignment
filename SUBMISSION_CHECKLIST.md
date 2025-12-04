# AWS Assignment Submission Checklist

## Status: CODE COMPLETE ✅ | AWAITING AWS DEPLOYMENT

---

## TASK 1: VPC Networking & Subnetting

- ✅ **main.tf** created with:
  - 1 VPC (10.0.0.0/16)
  - 2 Public Subnets (10.0.1.0/24, 10.0.2.0/24)
  - 2 Private Subnets (10.0.3.0/24, 10.0.4.0/24)
  - Internet Gateway
  - NAT Gateway with Elastic IP
  - Public & Private Route Tables
  - Resource associations

- ✅ **README.md** with:
  - Architecture explanation (4-6 lines) ✓
  - CIDR ranges table ✓
  - Key components description ✓
  - Placeholder for screenshots

- 📋 **To Do (When AWS Account Ready)**:
  - [ ] `terraform init`
  - [ ] `terraform plan`
  - [ ] `terraform apply`
  - [ ] Capture screenshots of VPC, Subnets, Route Tables, NAT Gateway
  - [ ] Add screenshots to README

---

## TASK 2: EC2 Static Website Hosting

- ✅ **main.tf** created with:
  - New VPC for Task 2
  - Public Subnet
  - Internet Gateway
  - Security Group (HTTP, HTTPS, SSH)
  - EC2 t2.micro instance
  - Nginx installation via user data
  - Resume HTML page auto-deployed
  - Public IP output

- ✅ **README.md** with:
  - Instance setup explanation ✓
  - Nginx installation steps ✓
  - Hardening measures ✓
  - Placeholder for screenshots

- 📋 **To Do (When AWS Account Ready)**:
  - [ ] `terraform init`
  - [ ] `terraform plan`
  - [ ] `terraform apply`
  - [ ] Note the public IP from terraform output
  - [ ] Visit http://<public-ip> in browser
  - [ ] Capture screenshots (EC2, Security Group, Website)
  - [ ] Add screenshots to README

---

## TASK 3: High Availability + Auto Scaling

- ✅ **main.tf** created with:
  - VPC with Multi-AZ subnets (public & private)
  - Internet Gateway & NAT Gateway
  - Route Tables (public & private)
  - ALB (Application Load Balancer)
  - Target Group with health checks
  - ALB Listener (port 80)
  - Launch Template with Nginx
  - Auto Scaling Group (Min 2, Max 4, Desired 2)
  - EC2 Security Group (allows ALB traffic)
  - ALB Security Group (allows internet traffic)

- ✅ **README.md** with:
  - HA architecture explanation ✓
  - Traffic flow diagram ✓
  - Component table ✓
  - Routing flow steps ✓
  - Placeholder for screenshots

- 📋 **To Do (When AWS Account Ready)**:
  - [ ] `terraform init`
  - [ ] `terraform plan`
  - [ ] `terraform apply`
  - [ ] Wait for instances to launch (3-5 minutes)
  - [ ] Verify ALB DNS name from output
  - [ ] Capture screenshots (ALB, Target Group, ASG, EC2 instances)
  - [ ] Test ALB URL - should see resume page
  - [ ] Add screenshots to README

---

## TASK 4: Billing & Cost Monitoring

- ✅ **main.tf** created with:
  - SNS Topic for alerts
  - Email subscription (UPDATE WITH YOUR EMAIL)
  - CloudWatch Billing Alarm (₹100 threshold)
  - Free Tier EC2 CPU Alert
  - NAT Gateway Data Transfer Alert
  - Multiple alarm actions to SNS

- ✅ **README.md** with:
  - Cost monitoring importance (explained) ✓
  - Causes of bill increases (table format) ✓
  - Monitoring setup explanation ✓
  - Best practices for Free Tier ✓
  - Cost estimation table ✓

- 📋 **To Do (When AWS Account Ready)**:
  - [ ] UPDATE email in main.tf before `terraform apply`
  - [ ] `terraform init`
  - [ ] `terraform plan`
  - [ ] `terraform apply`
  - [ ] Confirm SNS email subscription
  - [ ] Capture screenshots (Billing Alarms, Free Tier Usage)
  - [ ] Add screenshots to README

---

## TASK 5: Architecture Diagram

- ✅ **README.md** created with:
  - Architecture explanation (5-8 lines) ✓
  - All components listed ✓
  - Traffic flow explained ✓
  - Scaling strategy table ✓
  - Cost estimation ✓

- ✅ **architecture-description.txt** with:
  - Detailed layer-by-layer breakdown
  - All 7 layers documented
  - Traffic flow explanation

- ✅ **ARCHITECTURE_GUIDE.md** with:
  - Complete architecture summary
  - How to create diagram instructions
  - Metrics and thresholds
  - HA features
  - Security best practices

- 📋 **To Do (When You Have Time)**:
  - [ ] Open draw.io (https://draw.io)
  - [ ] Create architecture diagram using AWS icons
  - [ ] Include: Route 53, CloudFront, WAF, ALB, ASG, RDS, ElastiCache, S3, Monitoring
  - [ ] Export as PNG
  - [ ] Save to `task-5-architecture-diagram/architecture-diagram.png`
  - [ ] Optional: Save draw.io file (.drawio) to GitHub

---

## MAIN README.md

- ✅ Created with:
  - Repository structure ✓
  - All 5 tasks overview ✓
  - Getting started guide ✓
  - Deployment steps ✓
  - Resource naming conventions ✓
  - AWS region info ✓
  - Free tier considerations ✓
  - Cost estimates ✓
  - Cleanup instructions ✓
  - Troubleshooting section ✓
  - Submission checklist ✓

---

## GITHUB REPOSITORY

- ✅ Repository Created: https://github.com/Yashuppal-15/Flentas-AWS-Assignment
- ✅ All files organized in correct folders
- ✅ Each task has main.tf and README.md
- ✅ Main README.md at root level
- ✅ Public repository (visible to recruiter)

---

## FILES CREATED SUMMARY

Flentas-AWS-Assignment/
├── README.md ✅
├── SUBMISSION_CHECKLIST.md ✅
├── task-1-vpc/
│ ├── main.tf ✅
│ └── README.md ✅
├── task-2-ec2-website/
│ ├── main.tf ✅
│ └── README.md ✅
├── task-3-high-availability/
│ ├── main.tf ✅
│ └── README.md ✅
├── task-4-billing/
│ ├── main.tf ✅
│ └── README.md ✅
└── task-5-architecture-diagram/
├── README.md ✅
├── architecture-description.txt ✅
└── ARCHITECTURE_GUIDE.md ✅

**Total Files Created**: 14 files ✅

---

## NEXT STEPS (IN ORDER)

### Phase 1: IMMEDIATE (Before AWS Deployment)
- ✅ All code files created
- ✅ All documentation complete
- ⏳ **NEXT**: Push to GitHub

### Phase 2: When AWS Account is Ready
- ⏳ Deploy Task 1 (VPC)
- ⏳ Deploy Task 2 (EC2)
- ⏳ Deploy Task 3 (ALB + ASG)
- ⏳ Deploy Task 4 (Monitoring)
- ⏳ Create Task 5 diagram (draw.io)
- ⏳ Capture screenshots for all tasks
- ⏳ Update READMEs with screenshots
- ⏳ Push screenshots to GitHub

### Phase 3: Final Submission
- ⏳ Verify all files on GitHub
- ⏳ Delete all AWS resources (IMPORTANT!)
- ⏳ Verify resources deleted in AWS Console
- ⏳ Submit GitHub link to Flentas Technologies

---

## IMPORTANT REMINDERS

### Before Deploying to AWS
1. **Email in Task 4**: MUST update email in `task-4-billing/main.tf` before applying
2. **Resource Prefix**: All resources have `Yash_Uppal_` prefix as required
3. **AWS Region**: All tasks use `ap-south-1` (Mumbai)
4. **Free Tier**: Monitor daily to avoid unexpected charges

### During Deployment
1. **Order Matters**: Deploy tasks 1 → 2 → 3 → 4 (Task 5 is documentation only)
2. **Wait Between Deploys**: Wait 2-3 minutes after each `terraform apply`
3. **Verify Each Step**: Check AWS Console after each deployment
4. **Screenshot Everything**: Take screenshots of resources created

### After Deployment
1. **Test Everything**: Access website via public IP and ALB DNS
2. **Document Results**: Add screenshots to README files
3. **Push to GitHub**: Commit and push all changes
4. **CLEANUP IS MANDATORY**: Use `terraform destroy` for each task

### Resource Deletion Checklist
- [ ] Task 4: `terraform destroy` (monitoring)
- [ ] Task 3: `terraform destroy` (ALB, ASG, RDS)
- [ ] Task 2: `terraform destroy` (EC2)
- [ ] Task 1: `terraform destroy` (VPC, NAT, IGW)
- [ ] AWS Console: Verify no resources remain
- [ ] Elastic IPs: Delete any unattached IPs manually
- [ ] Confirm: $0 charges in billing console

---

## QUICK REFERENCE - Commands

### Initialize & Deploy
cd task-X-name
terraform init
terraform plan
terraform apply

### View Resources
terraform state list
terraform state show <resource-name>
terraform output

### Cleanup
terraform destroy

### Push to GitHub
git add .
git commit -m "Add Task X implementation"
git push origin main

---

## CURRENT STATUS

| Task | Code | Docs | Screenshots | Diagram | Status |
|------|------|------|-------------|---------|--------|
| Task 1 | ✅ | ✅ | ⏳ | N/A | Ready |
| Task 2 | ✅ | ✅ | ⏳ | N/A | Ready |
| Task 3 | ✅ | ✅ | ⏳ | N/A | Ready |
| Task 4 | ✅ | ✅ | ⏳ | N/A | Ready |
| Task 5 | N/A | ✅ | N/A | ⏳ | Ready |
| **Overall** | **✅** | **✅** | **⏳** | **⏳** | **READY FOR DEPLOYMENT** |

---

**Last Updated**: 2025-12-04 20:35 IST
**Ready for**: AWS Deployment & Screenshot Capture

# Task 2: EC2 Static Website Hosting with Nginx

## Approach Explanation

I deployed a free-tier eligible t2.micro EC2 instance in a public subnet with automatic public IP assignment. The instance uses Ubuntu 20.04 LTS AMI with a user data script that automatically installs and configures Nginx web server during launch. The security group is configured to allow HTTP (port 80), HTTPS (port 443), and SSH (port 22) traffic from anywhere, enabling external access to the website. The resume is served as a static HTML file through Nginx, making it accessible via the instance's public IP address on port 80. This setup follows AWS best practices for security groups and instance hardening with minimal permissions.

## Instance Setup & Hardening Steps

1. **Launch Configuration**: t2.micro instance (Free Tier eligible) in public subnet with auto-assigned public IP
2. **Security Hardening**:
   - Security group with explicit ingress rules (only HTTP, HTTPS, SSH)
   - Outbound traffic allowed to all destinations for updates
   - SSH access available for emergency management
3. **Nginx Installation**: Automated via user data script for repeatable deployment
4. **Website Hosting**: Static HTML resume served by Nginx on port 80
5. **Best Practices**:
   - Running latest Ubuntu OS updates
   - Nginx service enabled to start on reboot
   - Proper file permissions (755) set for web content
   - Minimal attack surface with only required ports open

## Screenshots

- EC2 Instance: ![EC2](./task-2-ec2-instance-screenshot.png)
- Security Group: ![Security Group](./task-2-security-group-screenshot.png)
- Website in Browser: ![Website](./task-2-website-screenshot.png)


## Terraform Code

See `main.tf` in this directory for complete IaC implementation.

## Resume Deployment

The resume is automatically deployed as `/var/www/html/index.html` containing:
- Professional summary
- Technical skills (JavaScript, TypeScript, React, Node.js, AWS, etc.)
- Project experience
- Education details
- Certifications and achievements

The website is fully responsive and styled for professional presentation.

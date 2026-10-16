# CloudScope

CloudScope is a cloud-native AWS infrastructure inventory and reporting API built with **Python, Flask, Terraform, Nginx, Gunicorn, IAM Roles, and GitHub Actions**.

The application retrieves live AWS infrastructure data using the AWS SDK (boto3) and exposes operational insights through REST API endpoints.

---

## Key Features

- AWS Identity Validation (STS)
- EC2 Inventory Reporting
- Running & Stopped Instance Reporting
- Infrastructure Summary Reporting
- IAM Role-Based Authentication
- Terraform-Provisioned Infrastructure
- Nginx Reverse Proxy
- Gunicorn Application Server
- GitHub Actions CI/CD Pipeline

---

## Architecture

```text
Developer
    │
    ▼
GitHub
    │
    ▼
GitHub Actions
    │
    ▼
SSH Deployment
    │
    ▼
EC2 (Amazon Linux 2023)
    │
    ▼
Nginx
    │
    ▼
Gunicorn
    │
    ▼
CloudScope API
    │
    ▼
IAM Instance Profile
    │
    ▼
IAM Role
    │
    ▼
AWS APIs
   ├── EC2
   └── STS
```

---

## Infrastructure

Infrastructure is provisioned and managed with Terraform:

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Instance
- IAM Role
- IAM Instance Profile
- S3 Remote Terraform Backend

---

## API Endpoints

| Endpoint | Description |
|-----------|-------------|
| `/health` | Health check |
| `/version` | Application version |
| `/identity` | AWS account identity |
| `/instances` | EC2 inventory |
| `/summary` | Infrastructure summary |
| `/running-instances` | Running EC2 instances |
| `/stopped-instances` | Stopped EC2 instances |

---

## CI/CD Pipeline

CloudScope uses GitHub Actions for automated deployments.

```text
git push
    ↓
GitHub Actions
    ↓
SSH into EC2
    ↓
git pull
    ↓
Install Dependencies
    ↓
Restart CloudScope
    ↓
Verify Service Status
```

---

## Technologies

- Python
- Flask
- boto3
- Terraform
- AWS EC2
- AWS IAM
- AWS STS
- Amazon Linux 2023
- Nginx
- Gunicorn
- systemd
- GitHub Actions
- Git
- GitHub

---

## Skills Demonstrated

- Infrastructure as Code (Terraform)
- AWS Networking & Security
- IAM Role Authentication
- Linux Administration
- Reverse Proxy Configuration
- Application Hosting
- CI/CD Automation
- GitHub Actions
- Deployment Troubleshooting
- Cloud Operations

---

## Project Status

✅ CloudScope v1.0 Complete

Features implemented:

- Infrastructure provisioning with Terraform
- AWS API integration using boto3
- Production deployment on EC2
- Nginx reverse proxy
- Gunicorn application hosting
- IAM role-based authentication
- GitHub Actions automated deployment pipeline

---

## Author

**Eugene Omons**

AWS Certified Solutions Architect – Associate

Cloud & DevOps Engineer focused on AWS, Terraform, Linux, Automation, and Infrastructure as Code.
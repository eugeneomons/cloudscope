# CloudScope

CloudScope is an AWS Infrastructure Inventory & Monitoring API built with Python, Flask, boto3, and Terraform.

The application retrieves live AWS infrastructure data and exposes it through REST API endpoints that provide inventory, reporting, and operational visibility.

---

## Features

- AWS Identity Validation (STS)
- EC2 Inventory Reporting
- Running Instance Reporting
- Stopped Instance Reporting
- Infrastructure Summary Reporting
- Terraform-Provisioned AWS Infrastructure

---

## Current Architecture

```text
Internet
    │
    ▼
CloudScope EC2
(Amazon Linux 2023)
    │
    ▼
Flask
    │
    ▼
boto3
    │
    ▼
AWS APIs
        │
        ├── EC2
        └── STS
```

---

## Infrastructure

CloudScope is deployed on AWS using Terraform-managed infrastructure:

- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Route Table Association
- Security Group
- EC2 Instance
- S3 Remote Terraform State Backend

---

## API Endpoints

| Endpoint | Description |
|-----------|-------------|
| `/` | Welcome page |
| `/health` | Health check |
| `/version` | Application version |
| `/identity` | AWS account identity |
| `/instances` | EC2 inventory |
| `/summary` | Infrastructure summary |
| `/running-instances` | Running EC2 instances |
| `/stopped-instances` | Stopped EC2 instances |

---

## Sample Response

```json
{
  "total_instances": 1,
  "running_instances": 1,
  "stopped_instances": 0
}
```

---

## Running Locally

```bash
git clone https://github.com/eugeneomons/cloudscope.git

cd cloudscope

python3 -m venv venv

source venv/bin/activate

pip install -r requirements.txt

python app.py
```

Access:

```text
http://127.0.0.1:5000
```

---

## Deployment Milestones

### AWS Infrastructure ✅

- Terraform Project Structure
- S3 Remote Backend
- VPC
- Public Subnet
- Internet Gateway
- Route Table
- Security Group
- EC2 Deployment

### Application Deployment ✅

- Python Runtime Installation
- Git Installation
- Dependency Management
- Flask Deployment
- Public Health Endpoint Verification

---

## Roadmap

### Completed ✅

- Flask API
- boto3 Integration
- EC2 Inventory Reporting
- AWS Deployment with Terraform
- Public EC2 Hosting

### In Progress 🚧

- Gunicorn
- Nginx Reverse Proxy
- Application Load Balancer
- HTTPS
- GitHub Actions CI/CD

### Future Enhancements

- `/instance/<instance_id>`
- `/public-instances`
- `/untagged-instances`
- `/security-groups`
- `/s3-buckets`
- CloudWatch Integration
- Operational Dashboard

---

## Technologies

- Python
- Flask
- boto3
- Terraform
- AWS EC2
- AWS VPC
- AWS STS
- Git
- GitHub
- Amazon Linux 2023

---

## Author

**Eugene Omons**

Cloud Engineering & DevOps Portfolio Project demonstrating AWS infrastructure provisioning, Python development, Infrastructure as Code, and cloud operations.
# CloudScope

CloudScope is an AWS Infrastructure Inventory & Monitoring API built with Python, Flask, boto3, Terraform, Gunicorn, and Nginx.

The application retrieves live AWS infrastructure data and exposes it through REST API endpoints that provide inventory, reporting, and operational visibility.

---

## Key Features

- AWS Identity Validation (STS)
- EC2 Inventory Reporting
- Running & Stopped Instance Reporting
- Infrastructure Summary Reporting
- IAM Role-Based Authentication
- Terraform-Provisioned AWS Infrastructure
- Nginx Reverse Proxy
- Gunicorn Application Server

---

## Architecture

```text
Internet
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
- Security Group
- IAM Role & Instance Profile
- EC2 Instance (Amazon Linux 2023)
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
  "running_instances": 1,
  "stopped_instances": 0,
  "total_instances": 1
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

### Infrastructure ✅

- Terraform Project Structure
- S3 Remote Backend
- VPC & Networking
- Security Groups
- EC2 Deployment
- IAM Role & Instance Profile

### Application Hosting ✅

- Python Virtual Environment
- Gunicorn Application Server
- systemd Service Management
- Nginx Reverse Proxy
- Role-Based AWS Authentication
- Public API Access

---

## Roadmap

### Completed ✅

- Flask API
- boto3 Integration
- EC2 Inventory Reporting
- Terraform Infrastructure
- IAM Role Authentication
- Gunicorn Deployment
- Nginx Reverse Proxy

### Next Up 🚧

- GitHub Actions CI/CD
- Application Load Balancer (ALB)
- HTTPS/TLS
- Automated Deployment Pipeline

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
- Nginx
- Gunicorn
- AWS EC2
- AWS IAM
- AWS STS
- AWS VPC
- Amazon Linux 2023
- Git
- GitHub

---

## Author

**Eugene Omons**

Cloud Engineering & DevOps portfolio project demonstrating Infrastructure as Code, AWS networking, IAM, Linux administration, application hosting, and cloud operations.
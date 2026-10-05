# CloudScope

AWS Infrastructure Inventory & Monitoring API built with Python, Flask, boto3, and AWS.

CloudScope provides a lightweight REST API for discovering, inventorying, and reporting on AWS infrastructure. The application retrieves live infrastructure data from AWS APIs and presents it through clean, structured, and easy-to-consume endpoints.

---

# Project Overview

Cloud engineers and infrastructure teams frequently need visibility into AWS environments without manually navigating the AWS Console.

CloudScope acts as an infrastructure visibility layer by:

- Connecting to AWS using boto3
- Retrieving live infrastructure data
- Transforming raw AWS API responses
- Exposing operational information through REST API endpoints
- Generating inventory and infrastructure summary reports

This project was built as a Cloud Engineering and DevOps portfolio project designed to demonstrate practical skills in AWS, Python, APIs, Infrastructure as Code, and CI/CD.

---

# Technologies Used

## Current Stack

- Python 3
- Flask
- boto3
- AWS EC2
- AWS STS
- Git
- GitHub

## Planned Technologies

- Terraform
- Nginx
- Gunicorn
- GitHub Actions
- Linux (Ubuntu)
- AWS VPC
- AWS Route53

---

# Current Architecture

```text
User
 │
 ▼
Flask API
 │
 ▼
boto3
 │
 ▼
AWS APIs
 │
 ├── STS
 └── EC2
```

---

# Target Production Architecture

```text
Internet
    │
    ▼
 Route53
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
   boto3
    │
    ▼
 AWS APIs
    │
    ├── EC2
    ├── STS
    ├── S3
    └── IAM
```

---

# API Endpoints

## Home

Returns a welcome message.

Endpoint:

```text
GET /
```

Example Response:

```text
Welcome to CloudScope! This is a simple Flask application that provides information about your AWS environment.
```

---

## Health Check

Returns application status.

Endpoint:

```text
GET /health
```

Example Response:

```json
{
  "status": "healthy"
}
```

---

## Version

Returns application version information.

Endpoint:

```text
GET /version
```

Example Response:

```json
{
  "version": "1.0.0"
}
```

---

## AWS Identity

Returns AWS account information from AWS STS.

Endpoint:

```text
GET /identity
```

Example Response:

```json
{
  "account": "123456789012",
  "arn": "arn:aws:iam::123456789012:user/example-user"
}
```

---

## EC2 Inventory

Returns all discovered EC2 instances.

Endpoint:

```text
GET /instances
```

Example Response:

```json
{
  "instances": [
    {
      "name": "flask-demo",
      "instance_id": "i-1234567890abcdef",
      "instance_type": "t3.micro",
      "state": "running",
      "public_ip": "35.xxx.xxx.xxx"
    }
  ]
}
```

---

## Infrastructure Summary

Returns aggregate infrastructure statistics.

Endpoint:

```text
GET /summary
```

Example Response:

```json
{
  "total_instances": 1,
  "running_instances": 1,
  "stopped_instances": 0
}
```

---

## Running Instances

Returns only running EC2 instances.

Endpoint:

```text
GET /running-instances
```

Example Response:

```json
{
  "instances": [
    {
      "name": "flask-demo",
      "instance_id": "i-1234567890abcdef",
      "instance_type": "t3.micro",
      "state": "running",
      "public_ip": "35.xxx.xxx.xxx"
    }
  ]
}
```

---

## Stopped Instances

Returns only stopped EC2 instances.

Endpoint:

```text
GET /stopped-instances
```

Example Response:

```json
{
  "instances": [
    {
      "name": "flask-demo",
      "instance_id": "i-1234567890abcdef",
      "instance_type": "t3.micro",
      "state": "stopped",
      "public_ip": "N/A"
    }
  ]
}
```

---

# Key Features

## AWS Infrastructure Discovery

Automatically discovers EC2 infrastructure via AWS APIs.

---

## Infrastructure Reporting

Provides summarized metrics for:

- Total instances
- Running instances
- Stopped instances

---

## Inventory Management

Provides a structured inventory of:

- Instance Names
- Instance IDs
- Instance Types
- Public IP Addresses
- Instance States

---

## AWS Identity Validation

Verifies AWS authentication through AWS Security Token Service (STS).

---

# Project Structure

```text
cloudscope/
│
├── app.py
├── requirements.txt
├── README.md
├── .gitignore
│
├── docs/
│
└── terraform/
```

---

# Running Locally

Clone the repository:

```bash
git clone https://github.com/eugeneomons/cloudscope.git

cd cloudscope
```

Create a virtual environment:

```bash
python3 -m venv venv
```

Activate:

```bash
source venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run the application:

```bash
python app.py
```

Access the API:

```text
http://127.0.0.1:5000
```

---

# Roadmap

CloudScope is an actively evolving Cloud Engineering portfolio project.

## Phase 1 – AWS Infrastructure Inventory API ✅

- [x] Flask API foundation
- [x] AWS STS integration
- [x] AWS EC2 inventory endpoint
- [x] Infrastructure summary endpoint
- [x] Running instance reporting
- [x] Stopped instance reporting
- [x] Refactored helper functions
- [x] GitHub repository

---

## Phase 2 – Infrastructure as Code 🚧

- [ ] Terraform project structure
- [ ] VPC deployment
- [ ] Subnet deployment
- [ ] Internet Gateway
- [ ] Route Tables
- [ ] Security Groups
- [ ] EC2 deployment for CloudScope hosting
- [ ] Terraform outputs and variables

---

## Phase 3 – Production Deployment 🚧

- [ ] Deploy CloudScope to EC2
- [ ] Configure Python virtual environment
- [ ] Configure Gunicorn
- [ ] Configure Nginx reverse proxy
- [ ] Public API endpoint
- [ ] HTTPS support

---

## Phase 4 – CI/CD 🚧

- [ ] GitHub Actions workflow
- [ ] Automated testing
- [ ] Automated deployment
- [ ] Service restart automation
- [ ] Versioned releases

---

## Phase 5 – Advanced AWS Visibility 🚧

- [ ] /instance/<instance_id>
- [ ] /public-instances
- [ ] /untagged-instances
- [ ] /security-groups
- [ ] /s3-buckets
- [ ] /dashboard

---

## Phase 6 – Monitoring & Operations 🚧

- [ ] Enhanced health checks
- [ ] CloudWatch integration
- [ ] Centralized logging
- [ ] Infrastructure metrics
- [ ] Operational dashboards

---

# Learning Objectives

This project demonstrates practical experience with:

- AWS Infrastructure
- Python Development
- Flask APIs
- boto3
- REST API Design
- Git & GitHub
- Infrastructure Inventory Management
- Cloud Operations
- Infrastructure as Code
- CI/CD Foundations

---

# Author

**Eugene Omons**

CloudScope is a continuously evolving Cloud Engineering and DevOps portfolio project focused on AWS Infrastructure Visibility, Automation, and Operational Reporting.
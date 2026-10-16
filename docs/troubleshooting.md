# CloudScope Troubleshooting Guide

This document captures major issues encountered during the deployment of CloudScope and the steps taken to diagnose and resolve them.

---
# 0. Security Group Connectivity Issue

## Issue:

CloudScope worked locally but was unreachable from the Internet.

Root Cause:

Security Group allowed:

- 22
- 80

but not:

- 5000

Resolution:

Added ingress rule for TCP 5000.

Verification:

http://<public-ip>:5000/health

# 1. Nginx Reverse Proxy Configuration

## Issue

CloudScope endpoints were inaccessible through Nginx even though:

- Nginx service was running
- Gunicorn service was running
- Port 80 was open in the Security Group

The browser displayed:

```text
404 Not Found
```

or the default:

```text
Welcome to nginx!
```

page.

---

## Root Cause

A custom Nginx reverse proxy configuration was created in:

```text
/etc/nginx/conf.d/cloudscope.conf
```

but Nginx was never reloaded after creating the new configuration.

As a result, Nginx continued serving the default configuration.

---

## Diagnosis

Verify configuration:

```bash
sudo nginx -t
```

Verify Nginx responds locally:

```bash
curl http://localhost
```

Expected result:

```html
Welcome to nginx!
```

---

## Resolution

Reload Nginx:

```bash
sudo systemctl reload nginx
```

Verify:

```bash
curl http://localhost/health
```

Expected result:

```json
{
  "status": "healthy"
}
```

---

## Lesson Learned

Changes to Nginx configuration files are not automatically loaded.

After configuration changes:

```text
Edit Configuration
      ↓
Validate Configuration
      ↓
Reload Nginx
```

---

# 2. AWS Region Configuration

## Issue

CloudScope endpoints that communicate with AWS returned:

```text
500 Internal Server Error
```

while static endpoints such as:

```text
/health
/version
```

continued to work.

---

## Root Cause

boto3 clients were created without specifying a region:

```python
boto3.client("ec2")
```

When CloudScope ran under:

```text
systemd
↓
Gunicorn
```

AWS region configuration was not available.

This resulted in:

```text
botocore.exceptions.NoRegionError:
You must specify a region.
```

---

## Diagnosis

Review CloudScope logs:

```bash
sudo journalctl -u cloudscope -n 50
```

Error:

```text
NoRegionError:
You must specify a region.
```

---

## Resolution

Explicitly configure region:

```python
ec2 = boto3.client(
    "ec2",
    region_name="ca-central-1"
)

sts = boto3.client(
    "sts",
    region_name="ca-central-1"
)
```

Restart CloudScope:

```bash
sudo systemctl restart cloudscope
```

---

## Lesson Learned

Applications running under systemd may not inherit the same environment as interactive shell sessions.

Do not assume:

```text
AWS Region
```

will automatically be available to the application.

---

# 3. IAM Authentication

## Issue

After fixing the region configuration, AWS-backed endpoints still failed.

Endpoints affected:

```text
/identity
/instances
/summary
/running-instances
/stopped-instances
```

---

## Root Cause

The EC2 instance had no IAM role attached.

CloudScope attempted to access AWS APIs but no credentials were available.

Error:

```text
botocore.exceptions.NoCredentialsError:
Unable to locate credentials
```

---

## Diagnosis

Test AWS CLI:

```bash
aws sts get-caller-identity
```

Output:

```text
Unable to locate credentials.
```

Check instance profile:

```bash
curl http://169.254.169.254/latest/meta-data/iam/security-credentials/
```

Output:

```text
(empty)
```

This confirmed that no IAM role was attached.

---

## Resolution

Created:

- IAM Role
- IAM Policy
- IAM Instance Profile

Minimum permissions:

```json
{
  "Action": [
    "ec2:DescribeInstances",
    "sts:GetCallerIdentity"
  ]
}
```

Attached instance profile to EC2.

Re-applied Terraform.

---

## Verification

Verify role attachment:

```bash
aws sts get-caller-identity
```

Expected:

```json
{
  "Account": "...",
  "Arn": "...assumed-role/cloudscope-role..."
}
```

Verify CloudScope endpoint:

```text
/identity
```

Response:

```json
{
  "account": "...",
  "arn": "arn:aws:sts::...:assumed-role/cloudscope-role/..."
}
```

---

## Lesson Learned

Never store AWS access keys on EC2 instances.

Preferred architecture:

```text
CloudScope
    ↓
IAM Instance Profile
    ↓
IAM Role
    ↓
Temporary AWS Credentials
    ↓
AWS APIs
```

This follows AWS security best practices.

---

# 4. Security Group Configuration

## Issue

CloudScope was accessible locally but unreachable from the Internet.

---

## Root Cause

Flask was listening on:

```text
Port 5000
```

but the Security Group did not allow inbound traffic on port 5000.

---

## Diagnosis

Local testing:

```bash
curl http://localhost:5000/health
```

returned:

```json
{
  "status":"healthy"
}
```

Browser access:

```text
http://<public-ip>:5000/health
```

timed out.

---

## Resolution

Temporarily allowed:

```text
TCP 5000
```

for testing.

After Nginx was implemented:

```text
TCP 5000
```

was removed from public access.

Final design:

```text
22 -> Admin IP
80 -> Internet
```

---

## Lesson Learned

Application-level testing and network-level testing should be performed separately:

```text
curl localhost
```

verifies the application.

```text
Browser/Public IP
```

verifies networking.
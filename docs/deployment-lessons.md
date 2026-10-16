## Dependency Issue

Problem:

Generated requirements.txt from a Python 3.12 environment caused package installation failures on Amazon Linux 2023 running Python 3.9.

Resolution:

Reduced requirements.txt to direct application dependencies:

- Flask
- boto3

Outcome:

CloudScope installed successfully on EC2.
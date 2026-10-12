# Troubleshooting

## Security Group Connectivity Issue

Problem:

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
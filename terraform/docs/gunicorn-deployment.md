# Gunicorn Deployment

## Objective

Replace Flask development server with a production-grade Python application server.

## Components Added

- Gunicorn
- systemd service

## Validation

- Gunicorn successfully serves CloudScope
- Public /health endpoint reachable
- CloudScope starts automatically at boot
- Service managed through systemctl

## Architecture

Internet
↓
Gunicorn
↓
CloudScope

## Key Commands

sudo systemctl start cloudscope

sudo systemctl status cloudscope

sudo systemctl enable cloudscope
``
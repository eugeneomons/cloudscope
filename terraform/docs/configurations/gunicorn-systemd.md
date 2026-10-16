# CloudScope Gunicorn systemd Configuration

CloudScope uses Gunicorn as the Python WSGI application server and systemd for service management.

## Service File

Location:

```text
/etc/systemd/system/cloudscope.service
```

Contents:

```ini
[Unit]
Description=CloudScope Gunicorn Service
After=network.target

[Service]
User=ec2-user
Group=ec2-user

WorkingDirectory=/home/ec2-user/cloudscope

Environment="PATH=/home/ec2-user/cloudscope/venv/bin"

ExecStart=/home/ec2-user/cloudscope/venv/bin/gunicorn \
    --workers 3 \
    --bind 0.0.0.0:5000 \
    app:app

Restart=always

[Install]
WantedBy=multi-user.target
```

---

## Reload systemd

After modifying the service file:

```bash
sudo systemctl daemon-reload
```

---

## Start Service

```bash
sudo systemctl start cloudscope
```

---

## Enable Automatic Startup

```bash
sudo systemctl enable cloudscope
```

---

## Restart Service

```bash
sudo systemctl restart cloudscope
```

---

## Check Service Status

```bash
sudo systemctl status cloudscope
```

Expected:

```text
active (running)
```

---

## Purpose

This configuration provides:

- Automatic startup on boot
- Automatic restart on failure
- Background execution
- Integration with GitHub Actions deployment pipeline
- Production-ready application hosting
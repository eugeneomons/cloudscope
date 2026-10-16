# CloudScope Nginx Reverse Proxy Configuration

CloudScope uses Nginx as a reverse proxy in front of Gunicorn.

## Architecture

```text
Internet
    ↓
Nginx (Port 80)
    ↓
Gunicorn (Port 5000)
    ↓
CloudScope API
```

---

## Configuration File

Location:

```text
/etc/nginx/conf.d/cloudscope.conf
```

Contents:

```nginx
server {

    listen 80;

    server_name _;

    location / {

        proxy_pass http://127.0.0.1:5000;

        proxy_set_header Host $host;

        proxy_set_header X-Real-IP $remote_addr;

        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_set_header X-Forwarded-Proto $scheme;

    }

}
```

---

## Validate Configuration

Before reloading Nginx:

```bash
sudo nginx -t
```

Expected:

```text
syntax is ok
test is successful
```

---

## Reload Configuration

```bash
sudo systemctl reload nginx
```

---

## Restart Nginx

```bash
sudo systemctl restart nginx
```

---

## Check Status

```bash
sudo systemctl status nginx
```

Expected:

```text
active (running)
```

---

## Enable Automatic Startup

```bash
sudo systemctl enable nginx
```

---

## Test Reverse Proxy

Health endpoint:

```text
http://<public-ip>/health
```

Version endpoint:

```text
http://<public-ip>/version
```

Inventory endpoint:

```text
http://<public-ip>/instances
```

---

## Notes

CloudScope exposes only:

```text
Port 80
```

to the internet.

Gunicorn listens internally on:

```text
Port 5000
```

and is accessed only through Nginx.

This architecture improves:

- Security
- Traffic handling
- Reverse proxy capability
- Production readiness
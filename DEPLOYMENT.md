# Imapsync Web - Docker Deployment

This setup uses Docker Compose to deploy the imapsync-web application with nginx as a reverse proxy.

## Quick Start

1. **Clone the repository:**
   ```bash
   git clone https://github.com/OpenThreat-ro/imapsync-web.git
   cd imapsync-web
   ```

2. **Start the services:**
   ```bash
   docker-compose up -d
   ```

3. **Access the application:**
   - Open your browser and go to `http://localhost`
   - The nginx proxy will forward requests to the imapsync-web application

## Configuration

### Services

- **imapsync-web**: The main application running on port 3000 (internal)
- **nginx**: Reverse proxy running on ports 80 and 443 (external)

### Nginx Configuration

The nginx configuration (`nginx.conf`) includes:
- Reverse proxy to the imapsync-web container
- WebSocket support for real-time output
- Static file serving
- Optional HTTPS configuration (commented out)

### SSL/HTTPS Setup (Optional)

To enable HTTPS:

1. **Uncomment HTTPS configuration** in `nginx.conf`
2. **Place your SSL certificates** in an `ssl` directory:
   ```
   ssl/
   ├── certificate.crt
   └── private.key
   ```
3. **Uncomment SSL volume** in `docker-compose.yml`:
   ```yaml
   volumes:
     - ./ssl:/etc/nginx/ssl:ro
   ```
4. **Update certificate paths** in `nginx.conf`

## Docker Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and restart
docker-compose up -d --build

# View running containers
docker-compose ps
```

## Networking

The services communicate through a custom Docker network (`imapsync-network`). The nginx container proxies requests to the `imapsync-web` container using the service name as hostname.

## Customization

### Environment Variables

You can add environment variables to the imapsync-web service in `docker-compose.yml`:

```yaml
environment:
  - NODE_ENV=production
  - CUSTOM_VAR=value
```

### Nginx Logs

To persist nginx logs, uncomment the logs volume in `docker-compose.yml`:

```yaml
volumes:
  - ./logs:/var/log/nginx
```

### Port Configuration

To change the external ports, modify the nginx ports mapping in `docker-compose.yml`:

```yaml
ports:
  - "8080:80"    # HTTP on port 8080
  - "8443:443"   # HTTPS on port 8443
```

## Troubleshooting

1. **Check container status:**
   ```bash
   docker-compose ps
   ```

2. **View application logs:**
   ```bash
   docker-compose logs imapsync-web
   ```

3. **View nginx logs:**
   ```bash
   docker-compose logs nginx
   ```

4. **Test nginx configuration:**
   ```bash
   docker-compose exec nginx nginx -t
   ```

5. **Restart services:**
   ```bash
   docker-compose restart
   ```
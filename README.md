# AGUWF Webhook

A lightweight and secure webhook server for automated deployments and GitHub integrations.

## Features

- 🚀 Automated deployment triggers
- 🔒 Secure webhook handling with secret authentication
- 🐳 Docker containerization
- 🔄 GitHub Actions integration for CI/CD
- 📁 Configurable hooks via JSON

## Prerequisites

- Node.js 14 or higher
- Docker (for containerized deployment)
- GitHub account (for CI/CD pipeline)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/aguwf-webhook.git
cd aguwf-webhook
```

2. Install dependencies:
```bash
npm install
```

3. Create a `.env` file with required environment variables:
```env
DOCKERHUB_USERNAME=your_dockerhub_username
DOCKER_IMAGE=aguwf-webhook
DOCKER_TAG=latest
DOCKER_CONTAINER=aguwf-webhook
DOCKER_CONTAINER_TEMP=aguwf-webhook-temp
```

4. Set up webhook secret:
```bash
echo "your-webhook-secret" > secrets/webhook-secret
```

## Configuration

The webhook configuration is stored in `hooks/base-hooks.json`. Example configuration:

```json
{
  "port": 3456,
  "path": "/webhook",
  "secret": "/secrets/webhook-secret",
  "hooks": [
    {
      "id": "redeploy",
      "execute-command": "/config/scripts/redeploy.sh",
      "command-working-directory": "/config/scripts",
      "response-message": "🚀 Running re-deployment!",
      "trigger-rule": {
        "match": {
          "type": "value",
          "value": "redeploy",
          "parameter": {
            "source": "payload",
            "name": "action"
          }
        }
      }
    }
  ]
}
```

## Docker Deployment

The Docker image is available for multiple architectures:
- AMD64 (x86_64) - Standard PCs/servers
- ARM64 (aarch64) - Modern ARM devices (M1/M2 Macs, newer Raspberry Pis)
- ARMv7 - Older ARM devices (Raspberry Pi 2/3)

Docker will automatically pull the correct architecture for your system:
```bash
docker pull yourusername/aguwf-webhook:latest
```

Run the container:
```bash
docker run -d \
  --name aguwf-webhook \
  -p 3456:80 \
  -v $(pwd)/secrets:/secrets \
  yourusername/aguwf-webhook:latest
```

For specific versions, you can use the commit SHA as tag:
```bash
docker pull yourusername/aguwf-webhook:{commit-sha}
```

## GitHub Actions

The project includes GitHub Actions workflow for automated Docker image building and pushing:

1. Add these secrets to your GitHub repository:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token

2. The workflow will automatically build and push the Docker image on pushes to the main branch.

## Webhook Endpoints

- **URL**: `http://your-server:3456/webhook`
- **Method**: `POST`
- **Headers**:
  - `Content-Type: application/json`
  - `X-Hub-Signature: sha1=...` (HMAC signature using your webhook secret)

Example payload:
```json
{
  "action": "redeploy"
}
```

## Directory Structure

```
aguwf-webhook/
├── .github/
│   └── workflows/
│       └── build.yml
├── hooks/
│   └── base-hooks.json
├── scripts/
│   └── deploy.sh
├── secrets/
│   └── .gitkeep
├── Dockerfile
├── webhook.js
├── package.json
└── README.md
```

## Security

- Webhook secrets are stored securely in the `/secrets` directory
- HMAC signature verification for webhook requests
- Docker container runs with minimal privileges

## Contributing

1. Fork the repository
2. Create your feature branch: `git checkout -b feature/my-feature`
3. Commit your changes: `git commit -am 'Add new feature'`
4. Push to the branch: `git push origin feature/my-feature`
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

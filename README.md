# granian255-python314t

Docker image with Python 3.14t (free-threaded) and pre-installed packages for Django + Granian WSGI server.

## Included Packages

- Django 5.2.7
- Granian 2.5.5 (free-threaded build for Python 3.14t)

## Base Image

`quay.io/pypa/manylinux_2_28_x86_64:latest`

## Usage

This image is designed to work with Kubernetes ConfigMap deployments where application code is mounted at runtime.

### Pull from GitHub Container Registry

```bash
docker pull ghcr.io/<your-username>/granian255-python314t:latest
```

### Local Build

```bash
docker build -t granian255-python314t .
```

### Run Locally

```bash
docker run -it granian255-python314t python3.14t --version
```

## CI/CD

GitHub Actions automatically builds and pushes this image to `ghcr.io` on every push to `main`.

## Kubernetes Deployment

Update your Kubernetes deployment to use the built image:

```yaml
spec:
  containers:
  - name: django
    image: ghcr.io/<your-username>/granian255-python314t:latest
    # ... rest of your config
```

## Setup

1. Create a GitHub repository named `granian255-python314t`
2. Push this code to the repository
3. The GitHub Action will automatically build and push the image
4. To pull images, authenticate with GitHub Container Registry:
   ```bash
   echo $GITHUB_TOKEN | docker login ghcr.io -u <your-username> --password-stdin
   ```

## License

MIT

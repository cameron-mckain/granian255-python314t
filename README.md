# granian-python

Docker images with Python 3.12, 3.13, 3.14, and 3.14t (free-threaded) pre-installed with Django, Granian WSGI server, and common packages.

## Available Python Versions

- **Python 3.12** - Stable release
- **Python 3.13** - Latest stable release
- **Python 3.14** - Latest stable (non-free-threaded)
- **Python 3.14t** - Free-threaded experimental build

## Included Packages

- Django 5.2.8
- Granian 2.5.7
- lxml, beautifulsoup4, requests, requests-toolbelt
- numpy, scipy, pandas, matplotlib
- Pillow, imagehash
- psycopg (PostgreSQL adapter)
- django-extensions, django-picklefield, django-jsoneditor
- pyyaml, python-magic, filetype
- channels-redis, django-cors-headers
- djangorestframework, django-filter
- graphene-django, django-channels-graphql-ws
- awscli

**Note:** opencv-python is not included due to free-threaded compatibility issues. Use pre-built wheels if needed.

## Base Image

`quay.io/pypa/manylinux_2_28_x86_64:latest`

## Usage

### Pull from Container Registry

**GitHub.com:**
```bash
docker pull ghcr.io/cameron-mckain/granian-python312:latest
docker pull ghcr.io/cameron-mckain/granian-python313:latest
docker pull ghcr.io/cameron-mckain/granian-python314:latest
docker pull ghcr.io/cameron-mckain/granian-python314t:latest
```

**GHES:**
```bash
docker pull containers.github.projectunity.io/mckain/granian-python312:latest
docker pull containers.github.projectunity.io/mckain/granian-python313:latest
docker pull containers.github.projectunity.io/mckain/granian-python314:latest
docker pull containers.github.projectunity.io/mckain/granian-python314t:latest
```

### Local Build

```bash
# Build for Python 3.14t (default)
docker build -t granian-python314t .

# Build for Python 3.12
docker build --build-arg PYTHON_VERSION=3.12 --build-arg PYTHON_PATH=cp312-cp312 -t granian-python312 .

# Build for Python 3.13
docker build --build-arg PYTHON_VERSION=3.13 --build-arg PYTHON_PATH=cp313-cp313 -t granian-python313 .

# Build for Python 3.14
docker build --build-arg PYTHON_VERSION=3.14 --build-arg PYTHON_PATH=cp314-cp314 -t granian-python314 .
```

### Run Locally

```bash
docker run -it granian-python314t python3.14t --version
docker run -it granian-python312 python3.12 --version
docker run -it granian-python313 python3.13 --version
docker run -it granian-python314 python3.14 --version
```

## CI/CD

GitHub Actions automatically builds all 4 Python versions and pushes to both registries on every push to `main`:

- Builds using matrix strategy (4 versions in parallel)
- Pushes to `ghcr.io/cameron-mckain/granian-python{312,313,314,314t}`
- Pushes to `containers.github.projectunity.io/mckain/granian-python{312,313,314,314t}`

## Kubernetes Deployment

Update your Kubernetes deployment to use the appropriate Python version:

```yaml
spec:
  containers:
  - name: django
    image: containers.github.projectunity.io/mckain/granian-python314t:latest
    # ... rest of your config
```

## AI/ML Specialized Image: ai-granian-python313

For AI/ML workloads, we provide a specialized image based on Python 3.13 with additional packages:

### Additional AI/ML Packages

- **Computer Vision**: opencv-python, dlib
- **NLP**: spacy, spacy-llm
- **Pre-installed spaCy models**:
  - en_core_web_sm (small, 12MB)
  - en_core_web_md (medium, 32MB)
  - en_core_web_lg (large, 383MB)
  - en_core_web_trf (transformer, 437MB)
- **Deep Learning**: PyTorch 2.9.0 (CPU-only)
- **Cloud AI**: azure-cognitiveservices-vision-computervision, google-cloud-storage
- **Social**: pytumblr

### Pull AI Image

**GitHub.com:**
```bash
docker pull ghcr.io/cameron-mckain/ai-granian-python313:latest
```

**GHES:**
```bash
docker pull containers.github.projectunity.io/mckain/ai-granian-python313:latest
```

### Local Build

```bash
docker build -f Dockerfile.ai -t ai-granian-python313 .
```

**Note**: Large wheels (PyTorch, spaCy models) are managed with Git LFS to keep repo size small while avoiding repeated downloads during builds.

### Image Size

Approximately 3-4GB (includes PyTorch CPU and all spaCy models)

## License

MIT

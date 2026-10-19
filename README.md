# K8S CI/CD Pipeline

A simple **Flask** web app containerized with **Docker**, built and deployed automatically to a **Kubernetes** cluster using a **Jenkins** pipeline.

![Python](https://img.shields.io/badge/Python-3.11-blue?logo=python&logoColor=white)
![Flask](https://img.shields.io/badge/Flask-black?logo=flask)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?logo=kubernetes&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?logo=jenkins&logoColor=white)

## Overview

Every pipeline run builds a new Docker image tagged with the Jenkins build number, pushes it to Docker Hub, and rolls it out to Kubernetes with zero manual steps.

## Tech Stack

- **App:** Python 3.11, Flask
- **Containerization:** Docker
- **Orchestration:** Kubernetes
- **CI/CD:** Jenkins (Declarative Pipeline)
- **Registry:** Docker Hub

## Project Structure

```
.
├── K8S/            # Kubernetes manifests (Deployment, Service)
├── Dockerfile      # Image build instructions
├── Jenkinsfile     # CI/CD pipeline definition
├── python.py       # Flask application
└── req.txt         # Python dependencies
```

## CI/CD Pipeline

The `Jenkinsfile` defines 3 stages:

| Stage | What it does |
|-------|--------------|
| **Build Image** | Builds the Docker image tagged `mennamedhat123/myapp:<BUILD_NUMBER>` |
| **Push Image** | Logs in to Docker Hub using Jenkins credentials and pushes the image |
| **Deploy to K8s** | Updates the image in `K8S/Deployment.yaml`, applies all manifests with `kubectl`, and waits for the rollout to finish |

Credentials are stored securely in Jenkins (`Docker` for Docker Hub, `kubeconfig` for cluster access), nothing is hardcoded in the repo.

## Run Locally

```bash
# Build the image
docker build -t myapp .

# Run the container
docker run -p 5000:5000 myapp
```

Then open http://localhost:5000 and you should see:

```
Hello from Kubernetes!
```

## Deploy Manually to Kubernetes

```bash
kubectl apply -f K8S/
kubectl rollout status deployment/myapp
```

## Jenkins Setup

1. Install Docker and `kubectl` on the Jenkins agent.
2. Add these credentials in Jenkins:
   - `Docker`: Username/Password for Docker Hub
   - `kubeconfig`: Secret file for your cluster
3. Create a Pipeline job pointing to this repo (Pipeline script from SCM).

## Author

**Menna Medhat**
[GitHub](https://github.com/mennamedhat11)

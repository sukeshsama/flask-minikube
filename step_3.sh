#!/bin/bash
cd python-flask-helloworld

# use minikube docker environment
eval $(minikube docker-env) || true

# Install local registry
docker run -d -p 5000:5000 --name registry registry:2.7

# Build Docker image
docker build -t localhost:5000/helloworlds/flask:latest .
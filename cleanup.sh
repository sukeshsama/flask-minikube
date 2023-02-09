#!/bin/bash

minikube kubectl -- delete deployment flask -n helloworlds-dev
minikube kubectl -- delete svc flask -n helloworlds-dev
minikube kubectl -- delete namespace helloworlds-dev
docker rmi -f registry:2.7
docker rmi -f localhost:5000/helloworlds/flask
minikube addons disable metallb
minikube stop
minikube delete --all
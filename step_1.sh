#!/bin/bash

CHECK_DOCKER_VERSION="docker version >/dev/null 2>&1"
eval "$CHECK_DOCKER_VERSION"
if [ $? -ne 0 ]
    then
        echo "Docker not installed, Install Docker https://docs.docker.com/get-docker/"
        exit 0
    else
        echo "+++++++++Docker Version++++++++++++++++++++++++++"
        docker version | head -2
        echo " "
fi
CHECK_MINI_KUBE_VERSION="minikube version >/dev/null 2>&1"
eval "$CHECK_MINI_KUBE_VERSION"
if [ $? -ne 0 ]
    then
        echo "MiniKube not installed, Install minikube https://minikube.sigs.k8s.io/docs/start/"
        exit 0
    else
        echo "+++++++++Minikube Version++++++++++++++++++++++++++"
        minikube version 
        echo " "
fi
    

# Flask Helloworld in Minikube
This document explains how to build Python3 Flask, and deploy and run the application in Minikube.

## Prerequisites 

- This application has been tested on Ubuntu 22.0 LTS. However, this should work on any Linux OS and WSL.
- [Minikube](https://minikube.sigs.k8s.io/docs/start/) and [Docker](https://docs.docker.com/engine/install/) should be Installed and running.
- Open the command terminal and start the minikube tunnel.
- zip/tar utility to extract the Zip/tar files.
- [Curl](https://curl.se/docs/install.html) utility to test the application.

## How to Build and Test the application

#### 
Open the terminal and run minikube start and then run [minikube tunnel](https://minikube.sigs.k8s.io/docs/handbook/accessing/#using-minikube-service-with-tunnel)
```sh
$minikube start
# minikube tunnel session should be kept open during the test session.
$minikube tunnel
```
Extract the **ssr-test.zip** or **ssr-test.tar** file and navigate to the extracted folder and execute the run.sh file
```sh
# Open a new terminal tab and execute the script
./run.sh
```
## More Information/folder contents
- ***run.sh*** - This script executes all shell scripts inside the folder in order step_1.sh, step_2.sh etc.
- ***step_1.sh*** - This script checks the minimum requirements like Minikube and Docker version Installed on your system.
- ***step_2.sh*** - This script starts the minikube and adds the [metallb](https://metallb.universe.tf/) load balancer addon.
- ***step_3.sh*** - This script builds the python3 flask Docker image and starts the [local registry container](https://docs.docker.com/registry/deploying/#run-a-local-registry).
- ***step_4.sh*** - This script Creates a namespace **hellowords-dev** and deploys the flask application.
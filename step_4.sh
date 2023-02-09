#!/bin/bash

# configure kubectl
alias kubectl="minikube kubectl --"

# create namespace
minikube kubectl -- create namespace helloworlds-dev

# deploy flask application and expose it to the service
minikube kubectl -- apply -f flask.yml -n helloworlds-dev


# Get the load balancer IP and access the flask application
COUNT=0
while [ $COUNT -le 10 ]
do
    echo "Attempt $COUNT"
    POD_STATUS=$(minikube kubectl -- get pods -n helloworlds-dev --no-headers | grep flask | grep -i running)
    ACCESSAPP=$(minikube service flask --url -n helloworlds-dev)
    echo "Access the app from the broswer using $ACCESSAPP/flask"
    echo  " "
    RESULT=$(curl -s $ACCESSAPP/flask)
    if [[ $RESULT =~ "Flask" ]] ; then
        echo " "
        echo "Found, Flask inside Docker"
        exit 0
    else
        echo " "
        echo " "
        echo "+++++++++  Re-try again +++++"
        
    fi
    COUNT=$(expr $COUNT + 1)
done
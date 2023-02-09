#!/bin/bash

echo "starting minikube"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
minikube start
alias kubectl="minikube kubectl --"

echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " "

echo "enable metallb addon for load balancer"
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo " "
minikube addons enable metallb

echo "configure Load balancer IP range"

MINIKUBEIP=$(minikube ip)
echo "MINIKUBE IP - $MINIKUBEIP"

# extract octets from the IPv4 address and configure the Load balnacer IP
# If MINIKUBE IP - 192.168.49.2
# Set Load Balancer starting IP - 192.168.49.7
# Set Load Balancer ending IP - 192.168.49.42

MINIKUBEIP_1=$(minikube ip |  cut -d . -f 1)
MINIKUBEIP_2=$(minikube ip |  cut -d . -f 2)
MINIKUBEIP_3=$(minikube ip |  cut -d . -f 3)
MINIKUBEIP_4=$(minikube ip |  cut -d . -f 4)

BUMP_START_IP=$(expr $MINIKUBEIP_4 + 5)
BUMP_END_IP=$(expr $MINIKUBEIP_4 + 40)

LLB_IP_START_IP="$MINIKUBEIP_1.$MINIKUBEIP_2.$MINIKUBEIP_3.$BUMP_START_IP"

LLB_IP_END_IP="$MINIKUBEIP_1.$MINIKUBEIP_2.$MINIKUBEIP_3.$BUMP_END_IP"

echo "Load Balancer starting IP - $LLB_IP_START_IP"
echo "Load Balancer ending IP - $LLB_IP_END_IP"

minikube kubectl -- version --short

cat <<EOF | minikube kubectl -- apply -f -
apiVersion: v1
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - $LLB_IP_START_IP-$LLB_IP_END_IP
kind: ConfigMap
metadata:
  name: config
  namespace: metallb-system
EOF

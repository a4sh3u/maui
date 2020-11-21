#!/usr/bin/env bash

# Add bitnami charts and install mysql db in k8s cluster. This config is for single master and no slaves
helm repo add bitnami https://charts.bitnami.com/bitnami
helm install maui-mysql -f mysql/values_custom.yaml bitnami/mysql
echo "MySql installed. Wait 60 secs".
sleep 60

# Add nginx charts and install nginx ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install maui-ing ingress-nginx/ingress-nginx
echo "Nginx controller installed. Wait 60 secs".
sleep 60

# Finally this the node app installation
helm install maui-app ./maui

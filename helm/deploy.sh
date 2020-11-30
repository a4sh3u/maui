#!/usr/bin/env bash

# Add bitnami charts and install mysql db in k8s cluster. This config is for single master and no slaves
helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade -i maui-mysql -f mysql/values_custom.yaml bitnami/mysql --version=7.1.0
echo "MySql installed. Wait 60 secs".
sleep 60

# Add nginx charts and install nginx ingress controller
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm upgrade -i maui-ing ingress-nginx/ingress-nginx --version=3.12.0
echo "Nginx controller installed. Wait 60 secs".
sleep 60

# Finally this the node app installation
helm upgrade -i maui-app ./maui

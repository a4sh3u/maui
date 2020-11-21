#!/usr/bin/env bash

# Install mysql with no slaves

# helm install mysql \
#   --set root.password=password,db.user=user,db.password=password,db.name=db,slave.replicas=0,\
#   initdbScripts=bitnami/mysql


# Do mysql ops to populate data and fix error with nodejs mysql-client unable to connect

helm install maui-mysql -f mysql/values_custom.yaml bitnami/mysql
# helm install maui-app ./maui

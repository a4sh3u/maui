#!/usr/bin/env bash

helm delete maui-mysql maui-app maui-ing
helm repo remove bitnami ingress-nginx

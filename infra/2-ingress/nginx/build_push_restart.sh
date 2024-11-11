#!/bin/bash
# infra/2-ingress/nginx/build_push_restart.sh
docker build -t gcr.io/socket-os/nginx .
docker push gcr.io/socket-os/nginx
kubectl delete pods -l app=nginx
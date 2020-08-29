#!/bin/bash

az login

python3 ./deploy-sql-big-data-aks.py

export AZDATA_USERNAME=admin
export AZDATA_PASSWORD=MySQLBigData2019

SQL_MASTER_ENDPOINT=$(kubectl get svc master-svc-external -n sqlbigdata --output jsonpath='{.status.loadBalancer.ingress[0].ip}')
KNOX_ENDPOINT=$(kubectl get svc gateway-svc-external -n sqlbigdata --output jsonpath='{.status.loadBalancer.ingress[0].ip}')

./bootstrap-sample-db.sh sqlbigdata $SQL_MASTER_ENDPOINT $KNOX_ENDPOINT
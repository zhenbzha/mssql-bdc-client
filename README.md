[SQL Server Big Data Clusters](https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-overview?view=sql-server-ver15) allows you to deploy scalable clusters of SQL Server, Spark, and HDFS containers running on Kubernetes. In order to deploy BDC e.g. to AKS, many dependencies and utilities need to be installed beforehand on local machine. To ease this process, a client container can be used, which includes all dependenices and necessary utilities are pre-installed.


## Prerquisites
Only prerequisites is to have docker installed on local machine. 

## Steps
1. login to docker hub `docker login --username=[yourdochubusername]`
2. download and run the BDC client container `docker run -it --name mssql-bdc-client zhenbzha/mssql-bdc-client:v1 /bin/bash`
3. inside container, log in to Azure `az login`
4. deploy BDC `python3 ./deploy-sql-big-data-aks.py` 
you need to input the subscription id, resource group name and region. Keep all others as default
5. set environment variables

```
export AZDATA_USERNAME=admin
export AZDATA_PASSWORD=MySQLBigData2019
```

If you are not using all default values in step 4, then update the values here accordingly as you specified in step 4.
6. load sample data into BDC
first run `kubectl get svc -n sqlbigdata` (sqlbigdata is the default BDC cluster name. if you specify different value in step 4, then use it here)
find the external ip of SQL_MASTER_ENDPOINT(master-svc-external) and KNOX_ENDPOINT(gateway-svc-external), then run command to load sample data to BDC
`./bootstrap-sample-db.sh sqlbigdata <SQL_MASTER_ENDPOINT> <KNOX_ENDPOINT>`

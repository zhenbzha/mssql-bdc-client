[SQL Server Big Data Clusters](https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-overview?view=sql-server-ver15) allows you to deploy scalable clusters of SQL Server, Spark, and HDFS containers running on Kubernetes. In order to deploy BDC e.g. to AKS, many dependencies and utilities need to be installed beforehand on local machine. To ease this process, a client container can be used, which includes all dependenices and necessary utilities are pre-installed.


## Prerquisites

Only prerequisites is to have docker installed on local machine. 

## Steps

1. login to docker hub `docker login --username=[yourdochubusername]`
2. download and run the BDC client container `docker run -it --name mssql-bdc-client -p 8888:8888  mssql-bdc-client`
3. Open jupyter notebook with URL provided in console
4. Open a terminal within jupyter notebook
5. run `./bootstrap.sh` 
you need to first login to Azure with code and then input the subscription id, resource group name and region. Keep all others as default
This will finish create BDC in Azure with all sample data loaded into the cluster

## References

[azdata commnds reference](https://docs.microsoft.com/en-us/sql/big-data-cluster/reference-azdata-bdc?view=sql-server-ver15)


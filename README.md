[SQL Server Big Data Clusters](https://docs.microsoft.com/en-us/sql/big-data-cluster/big-data-cluster-overview?view=sql-server-ver15) allows you to deploy scalable clusters of SQL Server, Spark, and HDFS containers running on Kubernetes. In order to deploy BDC e.g. to AKS, many dependencies and utilities need to be installed beforehand on local machine. To ease this process, a client container can be used, which includes all dependenices and necessary utilities are pre-installed.


## Prerquisites

Only prerequisites is to have docker installed on local machine. 

## Steps

1. download and run the BDC client container `docker run -it --name mssql-bdc-client zhenbzha/mssql-bdc-client /bin/bash`
2. inside docker, `cd bootstrap`
3. run `./bootstrap.sh` 
you need to first login to Azure and then input the subscription id, resource group name and region. Keep all others as default
This will finish create BDC in Azure with all sample data loaded into the cluster

## References

[azdata commnds reference](https://docs.microsoft.com/en-us/sql/big-data-cluster/reference-azdata-bdc?view=sql-server-ver15) \
[Hands on lab](https://github.com/microsoft/MCW-Modernizing-Data-Analytics-with-SQL-Server-2019/blob/0aa418a8a36dc51873fa6efb27c687b989a7536a/Hands-on%20lab/HOL%20step-by%20step%20-%20Modernizing%20Data%20Analytics%20with%20SQL%20Server%202019.md) \
[SQL BDC workshop](https://github.com/Microsoft/sqlworkshops-bdc#related)

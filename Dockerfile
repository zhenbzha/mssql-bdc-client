FROM ubuntu:18.04

ENV dir /bdc

# install prerequisites
RUN apt-get update && apt-get install -y \
    curl \
    python3.6 \
    apt-transport-https \
    gnupg2 \
    software-properties-common \
    vim \
    gnupg \
    ca-certificates \
    curl \
    wget \
    software-properties-common \
    lsb-release

# install sqlcmd
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/18.04/prod.list | tee /etc/apt/sources.list.d/msprod.list

RUN apt-get update && ACCEPT_EULA=Y apt-get install -y \
    mssql-tools \
    unixodbc-dev 

# install kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
RUN echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list

RUN apt-get update && apt-get install -y kubectl    

# install mssql-cli
RUN apt-add-repository https://packages.microsoft.com/ubuntu/18.04/prod

RUN apt-get update && apt-get install -y mssql-cli

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

# install azdata
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
RUN add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/18.04/mssql-server-2019.list)"

RUN apt-get update && apt-get install -y \
    azdata-cli

# install Azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

RUN mkdir ${dir}
WORKDIR ${dir}
COPY ./bootstrap-sample-db.sh ${dir}
COPY ./bootstrap-sample-db.sql ${dir}
COPY ./deploy-sql-big-data-aks.py ${dir}
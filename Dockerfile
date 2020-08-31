FROM ubuntu:18.04

ARG dir=bdc
ARG group=bdcadmin
ARG user=bdcadmin
ARG password=password

# create user and work dir
RUN groupadd -r ${group} && useradd --no-log-init --create-home -g ${group} ${user} && echo "${user}:${password}" | chpasswd && adduser bdcadmin sudo

# install prerequisites
RUN apt-get update && apt-get install -y \
    sudo \
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
    lsb-release \
    iputils-ping

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

RUN apt-get update && apt-get install -y azdata-cli

# install Azure cli
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

USER ${user}

RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN /bin/bash -c 'source ~/.bashrc'

RUN mkdir /home/${user}/${dir}
WORKDIR /home/${user}/${dir}

COPY --chown=${user}:${group} . .
RUN chmod ug+x /home/${user}/${dir}/bootstrap/bootstrap.sh
RUN chmod ug+x /home/${user}/${dir}/bootstrap/bootstrap-sample-db.sh

CMD ["tail", "-f", "/dev/null"]
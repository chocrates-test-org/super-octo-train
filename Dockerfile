FROM mcr.microsoft.com/azure-powershell:latest

RUN mkdir -p /usr/workspace

ENV HOME=/usr/workspace

RUN useradd -d "${HOME}" clouduser
RUN   chown -R clouduser:clouduser "${HOME}"
RUN  apt-get update -y
RUN  apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y
RUN  mkdir -p /etc/apt/keyrings
RUN  curl -sLS https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | tee /etc/apt/keyrings/microsoft.gpg > /dev/null
RUN  chmod go+r /etc/apt/keyrings/microsoft.gpg
RUN  echo "deb [arch=`dpkg --print-architecture` signed-by=/etc/apt/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list
RUN  apt-get update -y
RUN  apt-get install azure-cli -y

USER clouduser
WORKDIR /usr/workspace

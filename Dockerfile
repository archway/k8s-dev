FROM ubuntu:latest

ENV KUBECTL_VERSION 1.9.0
ENV HELM_VERSION 2.8.0
ENV HELM_FILENAME helm-v${HELM_VERSION}-linux-amd64.tar.gz

# install base apps
RUN apt-get update && apt install -y git openssh-client openssh-server gnupg curl make vim bash 

# setup ssh server
RUN mkdir /var/run/sshd
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN echo >> /etc/ssh/sshd_config
RUN echo 'X11UseLocalhost no' >> /etc/ssh/sshd_config

# install and setup Kubernetes client
RUN set -ex \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

RUN set -ex \
    && curl -sSL https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64

RUN helm init --client-only

# install X11 and GTK.
RUN apt-get update && apt-get install -y libgtk2.0-0 libgconf2-4 \
    libnss3 libasound2 libxtst6 libcanberra-gtk-module libgl1-mesa-glx libxss1 xauth \
    apt-transport-https fonts-takao

# install Visual Studio code
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &&\
    mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg &&\
    sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

RUN apt-get update && apt-get install -y code

# add user for develop
RUN useradd -ms /bin/bash me
RUN echo 'me:1qaz2wsx' | chpasswd
WORKDIR /home/me

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

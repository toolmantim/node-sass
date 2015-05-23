FROM centos:5

RUN yum install -y curl wget make file which

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm

RUN printf \
"[devtools-32]\n\
name=CentOS 5 devtools 32bit\n\
baseurl=http://people.centos.org/tru/devtools-2/5/i386/RPMS\n\
gpgcheck=0\n" > /etc/yum.repos.d/devtools32.repo

RUN printf \
"[devtools-64]\n\
name=CentOS 5 devtools 64bit\n\
baseurl=http://people.centos.org/tru/devtools-2/5/x86_64/RPMS\n\
gpgcheck=0\n" > /etc/yum.repos.d/devtools64.repo

RUN yum install -y devtoolset-2-{gcc,gcc-c++,binutils} git python26 glibc-devel.i386 devtoolset-2-libstdc++-devel.i386 \
    && mv /usr/bin/python /usr/bin/python_ \
    && mv /usr/bin/python26 /usr/bin/python

ENV PATH /opt/rh/devtoolset-2/root/usr/bin:$PATH
ENV PATH /opt/centos/devtoolset-1.0/root/usr/bin:$PATH

### install nvm ###

ENV NVM_NODEJS_ORG_MIRROR="https://nodejs.org/dist"
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.24.0/install.sh | bash
RUN cp /etc/pki/tls/certs/ca-bundle.crt /etc/pki/tls/certs/ca-bundle.crt.bak \
    && wget -O /etc/pki/tls/certs/ca-bundle.crt http://curl.haxx.se/ca/cacert.pem \
    && mkdir -p ~/.nvm/versions/io.js ~/.nvm/versions/node

### Add the code ###

ADD . /node-sass/
WORKDIR /node-sass

# Nuke any previous builds
RUN rm -rf vendor/*

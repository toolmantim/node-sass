FROM centos:5

RUN yum install -y curl wget make file which
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm

RUN printf \
"[devtools-32]\n\
name=CentOS 5 devtools 32bit\n\
baseurl=http://people.centos.org/tru/devtools-2/5/i386/RPMS\n\
gpgcheck=0\n" > \
/etc/yum.repos.d/devtools32.repo

RUN printf \
"[devtools-64]\n\
name=CentOS 5 devtools 64bit\n\
baseurl=http://people.centos.org/tru/devtools-2/5/x86_64/RPMS\n\
gpgcheck=0\n" >\
/etc/yum.repos.d/devtools64.repo

RUN yum install -y devtoolset-2-{gcc,gcc-c++,binutils} git python26
RUN yum install -y glibc-devel.i386 devtoolset-2-libstdc++-devel.i386

ENV PATH /opt/rh/devtoolset-2/root/usr/bin:$PATH

### install nvm ###

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.24.0/install.sh | bash
ENV NVM_NODEJS_ORG_MIRROR="https://nodejs.org/dist"
RUN cp /etc/pki/tls/certs/ca-bundle.crt /etc/pki/tls/certs/ca-bundle.crt.bak
RUN wget -O /etc/pki/tls/certs/ca-bundle.crt http://curl.haxx.se/ca/cacert.pem

### build node-sass ###

RUN echo "3.1.0"

ADD . /node-sass/

WORKDIR /node-sass

RUN mv /usr/bin/python /usr/bin/python_ && mv /usr/bin/python26 /usr/bin/python

ENV PATH /opt/centos/devtoolset-1.0/root/usr/bin:$PATH

RUN rm -rf vendor

RUN source ~/.nvm/nvm.sh && nvm install v0 && npm install && \
    node scripts/build.js -f

RUN source ~/.nvm/nvm.sh && nvm install v0.10 && \
    node scripts/build.js -f

RUN source ~/.nvm/nvm.sh && nvm install iojs-v1 && \
    node scripts/build.js -f

RUN source ~/.nvm/nvm.sh && nvm install iojs-v2 && \
    node scripts/build.js -f

RUN source ~/.nvm/nvm.sh && nvm install iojs-v1.0 && \
    node scripts/build.js -f

# now manually install x86 versions and build binaries #

RUN source ~/.nvm/nvm.sh && \
    wget http://nodejs.org/dist/v0.10.38/node-v0.10.38-linux-x86.tar.gz && \
    tar -C ~/.nvm/versions/node -xvf node-v0.10.38-linux-x86.tar.gz && \
    ln -sf ~/.nvm/versions/node/node-v0.10.38-linux-x86/bin/{npm,node} /bin  && \
    npm install && \
    node scripts/build.js -f

RUN source ~/.nvm/nvm.sh && \
    wget http://nodejs.org/dist/v0.12.2/node-v0.12.2-linux-x86.tar.gz && \
    tar -C ~/.nvm/versions/node -xvf node-v0.12.2-linux-x86.tar.gz && \
    ln -sf ~/.nvm/versions/node/node-v0.12.2-linux-x86/bin/{npm,node} /bin  && \
    node scripts/build.js -f

RUN source ~/.nvm/nvm.sh && \
    wget https://iojs.org/dist/v1.0.4/iojs-v1.0.4-linux-x86.tar.gz && \
    tar -C ~/.nvm/versions/io.js -xvf iojs-v1.0.4-linux-x86.tar.gz && \
    ln -sf ~/.nvm/versions/io.js/iojs-v1.0.4-linux-ia32/bin/{npm,node} /bin  && \
    node scripts/build.js -f

RUN source ~/.nvm/nvm.sh && \
    wget https://iojs.org/dist/v1.8.1/iojs-v1.8.1-linux-x86.tar.gz && \
    tar -C ~/.nvm/versions/io.js -xvf iojs-v1.8.1-linux-x86.tar.gz && \
    ln -sf ~/.nvm/versions/io.js/iojs-v1.8.1-linux-ia32/bin/{npm,node} /bin  && \
    node scripts/build.js -f

RUN source ~/.nvm/nvm.sh && \
    wget https://iojs.org/dist/v2.0.0/iojs-v2.0.0-linux-x86.tar.gz && \
    tar -C ~/.nvm/versions/io.js -xvf iojs-v2.0.0-linux-x86.tar.gz && \
    ln -sf ~/.nvm/versions/io.js/iojs-v2.0.0-linux-ia32/bin/{npm,node} /bin  && \
    node scripts/build.js -f

RUN ls vendor

RUN tar -cvzf binaries.tar.gz vendor/
FROM node:16.20.2-buster
# FROM ubuntu:20.04

#ENV TZ=Asia/Shanghai

# RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's|deb.debian.org|mirrors.ustc.edu.cn|g' /etc/apt/sources.list

RUN apt-get update
# RUN DEBIAN_FRONTEND=noninteractive apt install -y tzdata
RUN \
  apt-get install -y \
    tar \
    wget \
    build-essential

#RUN wget -nc  https://registry.npmmirror.com/-/binary/node/latest-v16.x/node-v16.19.1-linux-x64.tar.gz -O /tmp/node-v16.19.1-linux-x64.tar.gz
#RUN tar -C /usr/local --strip-components 1 -xzf /tmp/node-v16.19.1-linux-x64.tar.gz

RUN mkdir -p /opt/build/{web-apps,sdkjs}
WORKDIR /opt/app

COPY DocumentServer/web-apps/build/. /opt/build/web-apps/
COPY DocumentServer/sdkjs/build/. /opt/build/sdkjs/

RUN npm install -g grunt-cli --registry=http://registry.npmmirror.com

RUN cd /opt/build/web-apps/ \
    && npm install --registry=http://registry.npmmirror.com \
    && cd sprites && npm install --registry=http://registry.npmmirror.com \
    && cd ../plugins/grunt-inline && npm install --registry=http://registry.npmmirror.com

RUN npm cache clear --force
RUN cd /opt/build/sdkjs/ \
    && npm install --registry=http://registry.npmmirror.com \
    && cd deserializer && npm install --registry=http://registry.npmmirror.com

# enable sh
#RUN echo "dash dash/sh boolean false" | debconf-set-selections
#RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
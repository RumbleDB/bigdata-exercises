FROM ubuntu:24.04

LABEL maintainer="Tianxin Tang <titian.tang@gmail.com>"
LABEL maintainer="Ivan Ermilov <ivan.s.ermilov@gmail.com>"
LABEL maintainer="Giannis Mouchakis <gmouchakis@iit.demokritos.gr>"

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    openjdk-11-jdk \
    net-tools \
    curl \
    gnupg \
    netcat-traditional \
    libsnappy-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -O https://dist.apache.org/repos/dist/release/hadoop/common/KEYS

RUN gpg --import KEYS

# Note: for some reason, the version 3.4.1 and 3.4.2 does not have ARM64 builds
ENV HADOOP_VERSION=3.4.0

ARG TARGETARCH

RUN set -x \
    && case "${TARGETARCH}" in \
         arm64|aarch64) HADOOP_ARCH="aarch64" ;; \
         *) HADOOP_ARCH="" ;; \
       esac \
       
    && HADOOP_URL="https://www.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}${HADOOP_ARCH:+-${HADOOP_ARCH}}.tar.gz" \
    && echo "Downloading Hadoop from $HADOOP_URL" \
    && curl -kfSL "$HADOOP_URL" -o /tmp/hadoop.tar.gz \
    && curl -kfSL "$HADOOP_URL.asc" -o /tmp/hadoop.tar.gz.asc \
    && gpg --verify /tmp/hadoop.tar.gz.asc \
    && tar -xvf /tmp/hadoop.tar.gz -C /opt/ \
    && rm /tmp/hadoop.tar.gz*

RUN ln -s /opt/hadoop-$HADOOP_VERSION/etc/hadoop /etc/hadoop

RUN mkdir /opt/hadoop-$HADOOP_VERSION/logs

RUN mkdir /hadoop-data

ENV HADOOP_HOME=/opt/hadoop-$HADOOP_VERSION
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_CONF_DIR=/etc/hadoop
ENV MULTIHOMED_NETWORK=1
ENV USER=root
ENV PATH=$HADOOP_HOME/bin/:$PATH

ADD entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
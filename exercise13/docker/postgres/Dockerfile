FROM postgres:13.4-buster
MAINTAINER Ingo Müller <ingo.mueller@inf.ethz.ch>

ADD ./tpch /docker-entrypoint-initdb.d/
# Depdencies for importing data
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


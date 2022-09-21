FROM postgres:14.5
MAINTAINER Ingo Müller <ingo.mueller@inf.ethz.ch>

# Depdencies for importing data
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

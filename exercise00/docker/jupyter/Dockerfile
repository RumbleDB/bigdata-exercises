FROM jupyter/scipy-notebook:2021-09-13
MAINTAINER Ingo Müller <ingo.mueller@inf.ethz.ch>

USER root

# Python Postgres connector and dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade \
     ipython-sql==0.4.0 \
     psycopg2==2.9 \
    && true

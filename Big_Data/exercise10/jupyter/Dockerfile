FROM jupyter/scipy-notebook:python-3.11
LABEL org.opencontainers.image.authors="Ingo Müller <ingo.mueller@inf.ethz.ch>, Lennart K.M. Schulz <lschul@ethz.ch>"

USER root

# Installing Java

RUN mkdir -p /etc/apt/keyrings
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt-get update 
RUN apt install temurin-17-jdk -y

# Installing mongosh

RUN apt-get update
RUN apt-get install -y gnupg wget ca-certificates
RUN wget -qO- https://pgp.mongodb.com/server-7.0.asc | gpg --dearmor | tee /usr/share/keyrings/mongodb-server-7.0.gpg >/dev/null
RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" \
    | tee /etc/apt/sources.list.d/mongodb-org-7.0.list
RUN apt-get update
RUN apt-get install -y mongodb-mongosh
RUN rm -rf /var/lib/apt/lists/*

# Python Postgres connector and dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade \
     ipython==7.27.0\
     ipython-sql==0.4.0 \
     jsoniq==2.0.5 \
    && true

FROM jupyter/scipy-notebook

LABEL maintainer="Thomas Zhou <thzhou@student.ethz.ch>"
LABEL from="https://github.com/jupyter/docker-stacks/blob/master/pyspark-notebook"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Versions
ARG SPARK_VERSION=3.1.2
ARG OPENJDK_VERSION=8
ARG RUMBLE_FILENAME=v1.17.0/rumbledb-1.17.0-for-spark-3.2.jar

RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    "openjdk-${OPENJDK_VERSION}-jre-headless" \
    ca-certificates-java && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Spark and Rumble
WORKDIR /tmp
RUN wget -q "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz" && \
    tar xzf "spark-${SPARK_VERSION}-bin-hadoop2.7.tgz" -C /usr/local --owner root --group root --no-same-owner && \
    rm "spark-${SPARK_VERSION}-bin-hadoop2.7.tgz" && \
    wget --progress=dot:giga -O /usr/local/spark-${SPARK_VERSION}-bin-hadoop2.7/jars/spark-rumble-jar-with-dependencies.jar \
        https://github.com/RumbleDB/rumble/releases/download/${RUMBLE_FILENAME}

WORKDIR /usr/local

# Configure Spark
ENV SPARK_HOME=/usr/local/spark
ENV SPARK_WORKER_DIR=/var/spark
ENV PATH="${PATH}:${SPARK_HOME}/bin"

RUN ln -s "spark-${SPARK_VERSION}-bin-hadoop2.7" spark && \
    # Add a link in the before_notebook hook in order to source automatically PYTHONPATH
    mkdir -p /usr/local/bin/before-notebook.d && \
    ln -s "${SPARK_HOME}/sbin/spark-config.sh" /usr/local/bin/before-notebook.d/spark-config.sh

# Create alias for spark-submit under rumbledb
COPY rumble_entrypoint.sh "/usr/local/bin/rumbledb"

# Copy Log4j properties
COPY log4j.properties "/usr/local/spark/conf/log4j.properties"

USER ${NB_UID}

# Install pyarrow
RUN mamba install --quiet --yes \
    'pyarrow' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

WORKDIR "${HOME}"

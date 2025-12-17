FROM python:3.13.7-bookworm
# Apparently it is Debian 12 (Bookworm). This is important to know how to look up commands.
# RUN apt update && apt install libpq-dev python3-dev gcc python3-pip -y 

# Installing Java

RUN mkdir -p /etc/apt/keyrings
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc
RUN echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list
RUN apt-get update 
RUN apt install temurin-8-jdk -y

# alternate way to install Java if it does not work
#RUN apt update
#RUN apt install -y gnupg ca-certificates curl
#RUN curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
#RUN echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
#RUN apt update
#RUN apt install -y zulu8-jdk

RUN python3 -m pip install --upgrade pip

WORKDIR /root

COPY requirements.txt ./requirements.txt

RUN pip3 install -r requirements.txt

COPY jupyter_lab_config.py ./.jupyter/jupyter_notebook_config.py

CMD jupyter lab --allow-root  --ip 0.0.0.0 --no-browser --port 8888

FROM python:3.9.18
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
RUN python3 -m pip install notebook==7.0.8 ipython-sql==0.5.0 psycopg2==2.9.9  
RUN pip3 install pyspark==3.4.3
RUN pip3 install findspark
RUN pip3 install sparksql-magic
RUN pip3 install rumbledb
RUN pip3 install pandas
RUN pip3 install matplotlib
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = u''" >> $HOME/.jupyter/jupyter_notebook_config.py
CMD jupyter notebook --allow-root  --ip 0.0.0.0 --no-browser --port 8888

FROM python:3.9.0
FROM openjdk:8-slim-buster
RUN apt update && apt install libpq-dev python3-dev gcc python3-pip wget -y
RUN python3 -m pip install --upgrade pip && pip install notebook==6.4.12 ipython-sql==0.4.1 psycopg2==2.9.4  
RUN pip3 uninstall -y sqlalchemy
RUN pip3 install sqlalchemy==1.4.41
RUN pip3 install pyspark==3.2.0
RUN pip3 install findspark
RUN pip3 install sparksql-magic
RUN pip3 install rumbledb
RUN pip3 install matplotlib
RUN pip3 install pandas
RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = u''" >> $HOME/.jupyter/jupyter_notebook_config.py
CMD jupyter notebook --allow-root  --ip 0.0.0.0 --no-browser --port 8888

FROM openjdk:8-slim-buster
RUN apt update && apt install wget -y --no-install-recommends
RUN wget https://github.com/RumbleDB/rumble/releases/download/v1.21.0/rumbledb-1.21.0-standalone.jar
CMD java -jar /rumbledb-1.21.0-standalone.jar serve -p 9090 --host rumble

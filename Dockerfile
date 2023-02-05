# syntax=docker/dockerfile:1
FROM debian:stable-slim
EXPOSE 80/udp
EXPOSE 80/tcp
RUN apt-get update && apt-get install -y wget unzip bash
RUN wget https://github.com/thepeacockproject/Peacock/releases/download/v5.7.1/Peacock-v5.7.1.zip \
&& unzip Peacock-v5.7.1.zip \
&& mv Peacock-v5.7.1/ Peacock/ \
&& rm Peacock-v5.7.1.zip \
&& rm -r Peacock/nodedist \
&& wget -O node.tar.gz https://nodejs.org/dist/v18.12.1/node-v18.12.1-linux-x64.tar.gz \
&& tar -xzf node.tar.gz --directory Peacock \
&& mv ./Peacock/node-v18.12.1-linux-x64 ./Peacock/node \
&& rm node.tar.gz
WORKDIR /Peacock
COPY ["start_server.sh", "start_server.sh"]
RUN chmod a+x start_server.sh
CMD ["./start_server.sh"]
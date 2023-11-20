# syntax=docker/dockerfile:1
FROM debian:stable-slim
EXPOSE 80/udp
EXPOSE 80/tcp
RUN apt-get update && apt-get install -y wget unzip bash curl
RUN curl -s https://api.github.com/repos/thepeacockproject/Peacock/releases/latest \
    | grep "browser_download_url.*zip" | grep -v "lite"\
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -q -O Peacock.zip -i -
RUN unzip -q Peacock.zip \
    && rm Peacock.zip \
    && mv Peacock-* Peacock/ \
    && rm -r Peacock/nodedist \
    && wget -q -O node.tar.gz https://nodejs.org/dist/v18.18.2/node-v18.18.2-linux-x64.tar.gz \
    && tar -xzf node.tar.gz --directory Peacock \
    && mv ./Peacock/node-v18.18.2-linux-x64 ./Peacock/node \
    && rm node.tar.gz
WORKDIR /Peacock
RUN mkdir {userdata,contractSessions}
COPY ["start_server.sh", "start_server.sh"]
RUN chmod a+x start_server.sh
CMD ["./start_server.sh"]

VOLUME /Peacock/userdata
VOLUME /Peacock/contractSessions
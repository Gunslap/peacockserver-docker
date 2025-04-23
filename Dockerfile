# syntax=docker/dockerfile:1
FROM debian:stable-slim
EXPOSE 80/udp
EXPOSE 80/tcp
RUN apt-get update && apt-get install -y wget unzip bash curl xz-utils
RUN curl -s https://api.github.com/repos/thepeacockproject/Peacock/releases/latest \
    | grep "browser_download_url.*zip" | grep -E "linux" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget -q -O Peacock.zip -i -
RUN unzip -q Peacock.zip \
    && rm Peacock.zip \
    && mv Peacock-* Peacock/ \
    && wget -q -O node.tar.xz https://nodejs.org/dist/v22.14.0/node-v22.14.0-linux-x64.tar.xz \
	&& mkdir Peacock/node \
    && tar -xf node.tar.xz --directory Peacock/node --strip-components=1 \
    && rm node.tar.xz
WORKDIR /Peacock
RUN mkdir userdata
RUN mkdir contractSessions
RUN mkdir plugins

COPY ["start_server.sh", "start_server.sh"]
RUN chmod a+x start_server.sh
ENTRYPOINT ["./start_server.sh"]

VOLUME /Peacock/userdata
VOLUME /Peacock/contractSessions
VOLUME /Peacock/plugins
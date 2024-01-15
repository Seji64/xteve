FROM debian:12-slim
MAINTAINER seji@tihoda.de
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN apt update && \
    apt upgrade -y && \
    apt install --no-install-recommends --no-install-suggests -y ffmpeg curl unzip tini ca-certificates && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \   
    curl --location https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip --output temp.zip; unzip temp.zip -d /usr/bin/; rm temp.zip

ADD entrypoint.sh /

RUN chmod +x /entrypoint.sh && \
    chmod +x /usr/bin/xteve

# Volumes
VOLUME /config
VOLUME /root/.xteve
VOLUME /tmp/xteve

# Expose Port
EXPOSE 34400

# Entrypoint
ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/bin/bash","/entrypoint.sh"]

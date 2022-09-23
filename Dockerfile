FROM debian:11-slim
MAINTAINER seji@tihoda.de
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

RUN apt update && \
    apt upgrade -y && \
    apt install --no-install-recommends -y ffmpeg vlc curl wget unzip && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \   
    wget https://github.com/xteve-project/xTeVe-Downloads/raw/master/xteve_linux_amd64.zip -O temp.zip; unzip temp.zip -d /usr/bin/; rm temp.zip

ADD cronjob.sh /
ADD entrypoint.sh /
ADD sample_cron.txt /
ADD sample_xteve.txt /

RUN chmod +x /entrypoint.sh && \
    chmod +x /cronjob.sh && \
    chmod +x /usr/bin/xteve

# Volumes
VOLUME /config
VOLUME /root/.xteve
VOLUME /tmp/xteve

# Expose Port
EXPOSE 34400

# Entrypoint
ENTRYPOINT ["./entrypoint.sh"]

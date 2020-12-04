FROM linuxserver/nzbget

ENV SMA_UPDATE=false
ENV SMA_RS=nzbget
ENV SMA_PATH=/usr/local/sma

RUN \
    apk update && \
    apk add git wget python3-dev py3-pip py3-setuptools alpine-sdk libffi-dev openssl-dev && \
    mkdir ${SMA_PATH} && \
    mkdir /app/nzbget/scripts && \
    git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git ${SMA_PATH} && \
    ln -s /usr/local/sma/NZBGetPostProcess.py /app/nzbget/scripts/ && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install -r ${SMA_PATH}/setup/requirements.txt && \
    wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-amd64-static.tar.xz -O /tmp/ffmpeg.tar.xz && \
    tar -xJf /tmp/ffmpeg.tar.xz -C /usr/local/bin --strip-components 1 && \
    chgrp users /usr/local/bin/ffmpeg && \
    chgrp users /usr/local/bin/ffprobe && \
    chmod g+x /usr/local/bin/ffmpeg && \
    chmod g+x /usr/local/bin/ffprobe && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

VOLUME ["/usr/local/sma/config"]
VOLUME ["/downloads"]
VOLUME ["/config"]

EXPOSE 6789

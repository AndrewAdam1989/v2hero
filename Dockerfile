FROM alpine:latest

ENV CONFIG_JSON1=none CONFIG_JSON2=none UUID=00000000-0000-0000-0000-000000000000 CONFIG_JSON3=none ALTERID=64 CONFIG_JSON4=none VER=3.21

RUN apk add --no-cache --virtual .build-deps ca-certificates curl \
 && mkdir -m 777 /cbin \
 && cd /cbin \
 && curl -L -H "Cache-Control: no-cache" -o v2ray.zip https://github.com/v2ray/v2ray-core/releases/download/v$VER/v2ray-linux-64.zip \
 && unzip v2ray.zip \
 && mv /cbin/v2ray-v$VER-linux-64/v2ray /cbin/calc \
 && mv /cbin/v2ray-v$VER-linux-64/v2ctl /cbin/ \
 && mv /cbin/v2ray-v$VER-linux-64/geoip.dat /cbin/ \
 && mv /cbin/v2ray-v$VER-linux-64/geosite.dat /cbin/ \
 && chmod +x /cbin/calc \
 && rm -rf v2ray.zip \
 && rm -rf v2ray-v$VER-linux-64 \
 && chgrp -R 0 /cbin \
 && chmod -R g+rwX /cbin

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

#ENTRYPOINT /entrypoint.sh

CMD /entrypoint.sh

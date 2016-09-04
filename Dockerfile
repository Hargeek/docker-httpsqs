FROM alpine:latest
MAINTAINER ety001 <ety001@domyself.me>
RUN apk add --no-cache --update-cache bash alpine-sdk zlib-dev bzip2-dev bsd-compat-headers && mkdir /source \
        && wget https://github.com/ety001/docker-httpsqs/raw/master/httpsqs-1.7.tar.gz -O /source/httpsqs-1.7.tar.gz \
        && wget https://github.com/ety001/docker-httpsqs/raw/master/libevent-2.0.12-stable.tar.gz -O /source/libevent-2.0.12-stable.tar.gz \
        && wget https://github.com/ety001/docker-httpsqs/raw/master/tokyocabinet-1.4.47.tar.gz -O /source/tokyocabinet-1.4.47.tar.gz \
        && tar zxf /source/libevent-2.0.12-stable.tar.gz -C /source \
        && tar zxf /source/tokyocabinet-1.4.47.tar.gz -C /source \
        && tar zxf /source/httpsqs-1.7.tar.gz -C /source \
        && cd /source/libevent-2.0.12-stable && ./configure --prefix=/usr/local/libevent-2.0.12-stable/ && make && make install \
        && cd /source/tokyocabinet-1.4.47 && ./configure --prefix=/usr/local/tokyocabinet-1.4.47/ && make && make install \
        && cd /source/httpsqs-1.7 && make && make install \
        && cd / && rm -rf /source \
        && apk del alpine-sdk bsd-compat-headers \
        && wget https://raw.githubusercontent.com/ety001/docker-httpsqs/master/run_httpsqs.sh -O /run_httpsqs.sh \
        && chmod +x /run_httpsqs.sh
CMD ["/run_httpsqs.sh"]

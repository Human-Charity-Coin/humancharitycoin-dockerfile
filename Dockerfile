FROM debian:10.3-slim

ENV VERSION 1.1.0

ENV DATA "/data"

COPY entrypoint.sh /

RUN mkdir -p /opt && \
    cd /opt && \
    apt-get update -y && \
    apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    wget -O - https://github.com/Human-Charity-Coin/HCC-wallet/releases/download/v${VERSION}/hcclin${VERSION}tar.gz | tar xvz && \
    echo /opt/Human-Charity-Coin${VERSION}/lib > /etc/ld.so.conf.d/hcc.conf && \
    ldconfig && \
    mkdir -p "${DATA}" && \
    chmod 700 "${DATA}" && \
    chmod 555 /entrypoint.sh

ENV PATH /opt/Human-Charity-Coin${VERSION}/bin:$PATH

VOLUME ["/data"]

ENTRYPOINT ["/entrypoint.sh"]

CMD ["hccd"]
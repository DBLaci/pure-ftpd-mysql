FROM ubuntu:18.04

MAINTAINER László Szalma <dblaci@dblaci.hu>

ENV DEBIAN_FRONTEND noninteractive

ENV EXTERNALIP 127.0.0.1

# https://askubuntu.com/questions/496549/error-you-must-put-some-source-uris-in-your-sources-list
RUN sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y --allow-unauthenticated install dpkg-dev debhelper && \
    apt-get -y build-dep pure-ftpd-mysql && \
    mkdir /ftpdata && \
    mkdir /tmp/pure-ftpd-mysql && \
    cd /tmp/pure-ftpd-mysql && \
    apt-get source pure-ftpd-mysql && \
    cd pure-ftpd-* && \
    sed -i '/^optflags=/ s/$/ --without-capabilities/g' ./debian/rules && \
    dpkg-buildpackage -b -uc && \
    dpkg -i /tmp/pure-ftpd-mysql/pure-ftpd-common*.deb && \
    apt-get -y install openbsd-inetd && \
    dpkg -i /tmp/pure-ftpd-mysql/pure-ftpd-mysql*.deb && \
    apt-mark hold pure-ftpd pure-ftpd-mysql pure-ftpd-common && \
    groupadd ftpgroup && \
    useradd -g ftpgroup -d /dev/null -s /etc ftpuser && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

EXPOSE 20 21 30000-30019

ADD /run.sh /

CMD /run.sh

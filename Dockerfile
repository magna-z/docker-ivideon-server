FROM debian:10

ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive

RUN set -ex && \
    apt-get update && \
    apt-get install --yes --no-install-recommends gnupg && \
    apt-get upgrade --yes && \
    \
    echo 'deb [arch=amd64] http://packages.ivideon.com/ubuntu stable non-free' > /etc/apt/sources.list.d/ivideon.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C779A3833497297ABE5E3F8B1FBBBE38AC3A3973 && \
    apt-get update && \
    \
    apt-get install --yes --no-install-recommends ivideon-server-headless strace && \
    \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/log/alternatives.log /var/log/apt /var/log/dpkg.log
    
ENTRYPOINT ["/opt/ivideon/ivideon-server/videoserver"]

CMD ["--config-filename=/etc/videoserverd.config"]

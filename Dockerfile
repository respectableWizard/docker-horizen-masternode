FROM ubuntu:xenial
MAINTAINER respectableWizard

ARG USER_ID
ARG GROUP_ID
ARG VERSION

ENV USER horizen
ENV COMPONENT ${USER}
ENV HOME /home/${USER}

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g ${GROUP_ID} ${USER} \
    && useradd -u ${USER_ID} -g ${USER} -s /bin/bash -m -d ${HOME} ${USER}

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
RUN set -x \
    && apt-get update && apt-get -y --no-install-recommends install wget ca-certificates \
    && wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
    && wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
    && export GNUPGHOME="$(mktemp -d)" \
    && gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
    && rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true

RUN apt-get install -y --no-install-recommends  software-properties-common build-essential apt-transport-https lsb-release dirmngr pwgen git jq ufw curl aria2 \
    && apt-add-repository universe -y  \
    && echo 'deb https://zencashofficial.github.io/repo/ '$(lsb_release -cs)' main' | tee /etc/apt/sources.list.d/zen.list \
    && gpg --keyserver keyserver.ubuntu.com  --recv 219F55740BBF7A1CE368BA45FB7053CE4991B669  || gpg --keyserver ha.pool.sks-keyservers.net --recv 219F55740BBF7A1CE368BA45FB7053CE4991B669 \
    && gpg --export 219F55740BBF7A1CE368BA45FB7053CE4991B669 | apt-key add - \
    && apt-get update && apt-get -y install zen \
    && add-apt-repository ppa:certbot/certbot -y \
    && apt-get install certbot -y \
    && apt-get remove software-properties-common build-essential apt-transport-https lsb-release dirmngr pwgen git jq ufw curl aria2 -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove -y

EXPOSE 9033

VOLUME ["${HOME}"]
WORKDIR ${HOME}
ADD ./bin /usr/local/bin
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["start-unprivileged.sh"]

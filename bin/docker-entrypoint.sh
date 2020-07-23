#!/bin/bash
set -x

USER=horizen
DIR=$HOME/.zen

mkdir -p ${DIR}/letsencrypt/live
cp /etc/letsencrypt/live/${FQDN}/cert.pem ${DIR}/letsencrypt/live && \
cp /etc/letsencrypt/live/${FQDN}/privkey.pem ${DIR}/letsencrypt/live && \
cp /etc/letsencrypt/live/${FQDN}/chain.pem /usr/local/share/ca-certificates/chain.crt && \
update-ca-certificates && \
chown -R ${USER} . && \
exec gosu ${USER} "$@"
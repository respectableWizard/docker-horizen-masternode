#!/bin/bash
set -x

USER=horizen

chown -R ${USER} .
exec gosu ${USER} "$@"

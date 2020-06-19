#!/bin/bash
set -x

chown -R ${USER} .
exec gosu ${USER} "$@"
#!/bin/bash
set -x

EXECUTABLE=zend
DIR=$HOME/.zen
FILENAME=zen.conf
FILE=$DIR/$FILENAME

# create directory and config file if it does not exist yet
if [ ! -e "$FILE" ]; then
    mkdir -p $DIR

    echo "Creating $FILENAME"

    # Seed a random password for JSON RPC server
    # I might need to set daemon=0 and listen=0 just following the readme for now
    # 
    cat <<EOF > $FILE
printtoconsole=${PRINTTOCONSOLE:-1}
externalip=${EXTERNALIP}
rpcbind=127.0.0.1
rpcallowip=127.0.0.1
server=0
masternode=1
daemon=0
listen=0
txindex=1
logtimestamps=1
rpcuser=${RPCUSER:-horizenrpc}
rpcpassword="${RPCPASSWORD:-`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`}"
rpcprot=18231
rpcworkqueue=512
EOF

fi

cat $FILE
ls -lah $DIR/

echo "Initialization completed successfully"

zen-fetch-params && exec $EXECUTABLE
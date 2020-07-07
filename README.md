horizen masternode for docker
===================

Docker image that runs the horizen daemon which can be turned into a masternode with the correct configuration.

This docker node need 2 volumes mounts.

One to let's encrypt to cert dir
One to store the blockchain

# TODO
Quick Start 
-----------

```bash
docker run \
  -d \
  -p 9033:9033 \
  -v /some/directory:/horizen \
  --name=horizen \
  respectableWizard/horizen
```
# TODO
This will create the folder `.zen` in `/some/directory` with a bare `horizen.conf`. You might want to edit the `horizen.conf` before running the container because with the bare config file it doesn't do much, it's basically just an empty wallet.

# TODO
Start as masternode
-------------------

To start the masternode functionality, edit your horizen.conf (should be in /some/directory/.horizen/ following the docker run command example above):

```
rpcuser=<SOME LONG RANDOM USER NAME>
rpcpassword=<SOME LONG RANDOM PASSWORD>
rpcallowip=127.0.0.1
rpcbind=127.0.0.1
daemon=0
server=0
listen=0
txindex=1
logtimestamps=1
maxconnections=256
printtoconsole=1
masternode=1
rpcprot=18231
rpcworkqueue=512
```

Where `<SERVER IP ADDRESS>` is the public facing IPv4 or IPv6 address that the masternode will be reachable at.
Don't forget to put your IPv6 address in brackets! For example `[aaaa:bbbb:cccc::0]:9033`

`<MASTERNODE PRIVATE KEY>` is the private key that you generated earlier (with `horizen-cli masternode genkey`).

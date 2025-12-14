#!/bin/bash -e

set -e

rcon -t telnet -a "127.0.0.1:${TELNET_PORT}" -p "${PASSWORD}" listplayers

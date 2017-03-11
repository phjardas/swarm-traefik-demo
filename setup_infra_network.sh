#!/bin/bash -e
source ./config.sh

# issue all commands against manager-1
eval $(docker-machine env manager-1)

echo && echo "=== creating overlay network"
docker network create --driver=overlay traefik

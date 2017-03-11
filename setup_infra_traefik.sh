#!/bin/bash -e
source ./config.sh

# issue all commands against manager-1
eval $(docker-machine env manager-1)

echo && echo "=== deploying traefik"
docker stack deploy --compose-file=traefik-compose.yaml traefik

echo "You can access the traefik UI at http://$(docker-machine ip manager-1):8080/"

#!/bin/bash -e

source ./config.sh

# issue all commands against manager-1
eval $(docker-machine env manager-1)

echo && echo "=== creating overlay network"
docker network create --driver=overlay traefik

echo && echo "=== deploying portainer"
docker service create \
	--name portainer \
	--constraint=node.role==manager \
	--publish 9000:9000 \
	--mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
	portainer/portainer \
	-H unix:///var/run/docker.sock \
	--no-auth

echo "You can access portainer at http://$(docker-machine ip manager-1):9000/"

echo && echo "=== deploying traefik"
docker service create \
    --name traefik \
    --constraint=node.role==manager \
    --publish 80:80 --publish 8080:8080 \
    --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
    --network traefik \
	--replicas $no_of_managers \
    traefik:$traefik_version \
    --docker \
    --docker.swarmmode \
    --docker.exposedbydefault=false \
    --web

echo "You can access the traefik UI at http://$(docker-machine ip manager-1):8080/"

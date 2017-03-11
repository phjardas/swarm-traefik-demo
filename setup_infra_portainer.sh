#!/bin/bash -e
source ./config.sh

# issue all commands against manager-1
eval $(docker-machine env manager-1)

echo && echo "=== deploying portainer"
docker service create \
	--name portainer \
	--constraint=node.role==manager \
	--publish 9000:9000 \
	--mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
	portainer/portainer \
	-H unix:///var/run/docker.sock \
	--no-auth

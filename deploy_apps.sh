#!/bin/bash -e

source ./config.sh

# issue all commands against manager-1
eval $(docker-machine env manager-1)

echo && echo "=== deploying $no_of_apps test applications"

for i in $(seq 1 $no_of_apps); do
	APP_ID=$i docker stack deploy --compose-file=app-compose.yaml app-$i
done

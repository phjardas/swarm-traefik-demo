#!/bin/bash -e

source ./config.sh

# issue all commands against manager-1
eval $(docker-machine env manager-1)

echo && echo "=== deploying $no_of_apps test applications"
for i in $(seq 1 $no_of_apps); do
	# We only deploy to worker nodes to check if load-balancing from
	# traefik which runs on manager nodes only works.
	# The flag `traefik.backend.loadbalancer.swarm=false` bypasses the
	# built-in load-balancing of docker swarm and instead directly routes
	# to deployed instances. This reduces traffic overhead.
	# Note that we do not publish the HTTP port. It only needs to
	# be available internally to traefik via the overlay network `traefik`.
	docker service create \
		--name app-$i \
		--constraint=node.role==worker \
		--label traefik.enable=true \
		--label traefik.port=3000 \
		--label traefik.backend=app-$i \
		--label traefik.backend.loadbalancer.swarm=false \
		--label traefik.frontend.rule=PathPrefix:/apps/$i \
		--network traefik \
		--replicas $no_of_workers \
		docker-registry-maint.bd4travel.com:5000/info:0.1.0
done

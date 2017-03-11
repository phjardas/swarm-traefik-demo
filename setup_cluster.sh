#!/bin/bash -e

source ./config.sh

echo "=== creating $no_of_managers managers and ${no_of_workers} workers ==="

for i in $(seq 1 $no_of_managers); do
	echo && echo "== creating manager no. $i =="
	machine="manager-$i"
	docker-machine create --driver virtualbox --engine-opt bip=10.$(expr 100 + $i).1.1/16 $machine
	ip=$(docker-machine ip $machine)
	eval $(docker-machine env $machine)

	if [ $i == 1 ]; then
		echo && echo "= initializing swarm"
		docker swarm init --listen-addr $ip --advertise-addr $ip
		manager_token=$(docker swarm join-token manager -q)
		worker_token=$(docker swarm join-token worker -q)
	else
		echo && echo "= joining swarm as manager"
		docker swarm join --token $manager_token --listen-addr $ip --advertise-addr $ip $(docker-machine ip manager-1)
	fi
done

for i in $(seq 1 $no_of_workers); do
	echo && echo "== creating worker no. $i =="
	machine="worker-$i"
	docker-machine create --driver virtualbox --engine-opt bip=10.$(expr 200 + $i).1.1/16 $machine
	ip=$(docker-machine ip $machine)
	eval $(docker-machine env $machine)

	echo && echo "= joining swarm as worker"
	docker swarm join --token $worker_token --listen-addr $ip --advertise-addr $ip $(docker-machine ip manager-1)
done

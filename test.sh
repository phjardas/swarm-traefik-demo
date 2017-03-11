#!/bin/bash -e

source ./config.sh

# issue all commands against manager-1
eval $(docker-machine env manager-1)

echo && echo "=== testing"
sleep 5
echo "Accessing the test applications on all nodes:"
echo "The following hostnames should be evenly distributed, not always the same."
tries=3
for app in $(seq 1 $no_of_apps); do
	echo && echo "== application no. $app =="

	for i in $(seq 1 $no_of_managers); do
		cmd="curl -sS http://$(docker-machine ip manager-$i)/apps/$i"
		echo "$cmd | grep Hostname"
		for t in $(seq 1 $tries); do $cmd | grep Hostname; done
	done

	for i in $(seq 1 $no_of_workers); do
		cmd="curl -sS http://$(docker-machine ip worker-$i)/apps/$i"
		echo "$cmd | grep Hostname"
		for t in $(seq 1 $tries); do $cmd | grep Hostname; done
	done
done

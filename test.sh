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
		echo && echo "= http on manager-$i ="
		cmd="curl -sS http://$(docker-machine ip manager-$i)/apps/$i"
		echo "\$ $cmd"
		for t in $(seq 1 $tries); do $cmd; done

		echo && echo "= https on manager-$i ="
		cmd="curl -skS https://$(docker-machine ip manager-$i)/apps/$i"
		echo "\$ $cmd"
		for t in $(seq 1 $tries); do $cmd; done
	done
done

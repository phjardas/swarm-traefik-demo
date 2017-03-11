Docker Swarm Demo
=================

This is a demo to test and demonstrate a cloud deployment with Docker Swarm and Træfɪk.

The script starts several VMs with docker-machine and connects them together to a swarm mode cluster.

It then deploys portainer and traefik as well as a couple of replicated test applications whoami.

The goals of this projects are:
* to show that setting up a swarm mode cluster is really easy and quick.
* to provide an environment on which to simulate rolling updates, server crashes and the like.
* to test whether Træfɪk can act as a replacement for HAProxy as the production load-balancer.

Scripts
-------

* `./setup_cluster.sh` spins up the virtual machines and connects them to a swarm cluster.
* `./setup_infra.sh` deploys Portainer and Træfɪk.
* `./deploy_apps.sh` deploys a test application several times into the cluster.
* `./test.sh` performs some tests on the application.

Run `./swarm.sh` to run all the scripts in sequence.

Open issues
-----------

* Test SSL termination.
* Determine how to health-check applications. (maybe use docker's built-in HEALTHCHECK feature?)
* Test how the cluster behaves when an error occurs during a rolling update.
* How can we monitor Træfɪk's health automatically? Is there a New Relic plugin?
Use path-based routing instead of host-based.

Preconditions
-------------

* You need to have docker installed with a version of at least 1.12 (includes support for docker swarm mode). The docker binaries docker and docker-machine must be in your path.
* You need to have VirtualBox installed to manage the VMs.
* curl

Docker Swarm Demo
=================

This is a demo to test and demonstrate a cloud deployment with Docker Swarm Mode and Træfɪk.

The script starts several VMs with `docker-machine` and connects them together to a swarm mode cluster.

It then deploys [Portainer](https://portainer.readthedocs.io/) and [Træfɪk](https://traefik.io/) as well as a couple of replicated [test applications](https://github.com/phjardas/docker-testapp).

The goals of this project are:
* to show that setting up a production-ready swarm mode cluster is rather easy and quick.
* to provide an environment on which to simulate rolling updates, server crashes and the like.
* to test whether Træfɪk can act as a replacement for HAProxy as the production load-balancer.

Scripts
-------

* `./setup_cluster.sh` spins up the virtual machines and connects them to a swarm mode cluster.
* `./setup_infra.sh` deploys Portainer and Træfɪk.
* `./deploy_apps.sh` deploys a test application several times into the cluster.
* `./test.sh` performs some tests on the application.

Run `./swarm.sh` to run all the scripts in sequence.

Open issues
-----------

* Test how the cluster behaves when an error occurs during a rolling update.
* How can we monitor Træfɪk's health automatically? Is there a New Relic plugin?
* Can we use rewrite rules on path-based routes?

Prerequisites
-------------

* You need to have docker installed with a version of at least 1.12 (includes support for docker swarm mode). The docker binaries `docker` and `docker-machine` must be in your path.
* You need to have VirtualBox installed to manage the VMs.
* `curl` for testing.

Recommended Reading
-------------------

This "application" relies on quite a few technologies and concepts. I recommend you familiarize yourself with them before trying to understand the stuff happening in this demo.

* [Docker](https://docs.docker.com/)
* [Docker Swarm Mode](https://docs.docker.com/engine/swarm/)
* [Docker Services](https://docs.docker.com/engine/swarm/services/)
* [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/)
* [Docker Overlay Networks](https://docs.docker.com/engine/swarm/networking/)
* [Docker Compose](https://docs.docker.com/compose/)
* [Træfɪk](https://traefik.io/) and [Træfɪk in Docker Swarm Mode](https://docs.traefik.io/user-guide/swarm-mode/)

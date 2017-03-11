#!/bin/bash -e

./setup_cluster.sh
./setup_infra.sh
./deploy_apps.sh
./test.sh

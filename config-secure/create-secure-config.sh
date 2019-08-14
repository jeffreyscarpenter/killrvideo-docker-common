#!/bin/bash

set -e  # Bail if something fails

# This script creates configuration files for running DSE with authentication and 
# authorization enabled. These configuration files override the defaults in the image

DSE_VERSION=${1:-6.7.4}

# create a dummy container for the purposes of extracting configuration files
CONTAINER=$(docker create datastax/dse-server:$DSE_VERSION)
docker cp $CONTAINER:/opt/dse/resources/dse/conf/dse.yaml .
docker rm $CONTAINER

# append lines enabling DSE Authenticator to dse.yaml
echo "authentication_options:
    enabled: true
role_management_options:
    mode: internal
authorization_options:
    enabled: true" >> dse.yaml


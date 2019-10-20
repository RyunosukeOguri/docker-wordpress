#!/bin/bash
# set -ex

source ./.env

docker run -it --rm \
  --volumes-from $WORDPRESS_CONTAINER_NAME \
  --network container:$WORDPRESS_CONTAINER_NAME \
  wordpress:cli wp "$@"
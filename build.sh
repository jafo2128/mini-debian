#!/bin/bash

[[ "$1" = "" ]] && { echo "Requires docker image name" ; exit 1 ; }
docker_image=$1

container=`docker create debian:9.1 sleep 1000000`
docker start ${container}
docker exec -it ${container} rm -rf /usr/share/man /usr/share/doc /usr/share/locale
docker export ${container} | docker import - $docker_image
docker kill ${container}
echo "New mini-debian image is ${docker_image}"
docker images ${docker_image}

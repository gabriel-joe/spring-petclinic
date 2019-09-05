#!/bin/bash

set -ev

apt-get install libxml2-utils -y
export DOCKER_VERSION = $(xmllint --xpath '/*[local-name()="project"]/*[local-name()="properties"]/*[local-name()="docker-version"]/text()' pom.xml)
app_name="spring-petclinic"
app_image="${DOCKER_USERNAME}/${app_name}:${DOCKER_VERSION}"

unset DOCKER_CERT_PATH
unset DOCKER_HOST
unset DOCKER_TLS
unset DOCKER_TLS_VERIFY

docker build -t "${app_image}" .
docker login -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}"
docker images
docker push "${app_image}"

exit 0
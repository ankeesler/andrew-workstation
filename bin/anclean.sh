#!/bin/bash

set -e

docker ps -a -q | xargs docker rm
docker image prune --force

brew cleanup

#!/bin/bash

set -e

docker ps -a -q | xargs docker rm
docker image prune --force
docker system prune --all --force --volumes

brew cleanup

du -sh /System/Library/Caches/com.apple.coresymbolicationd/data
sudo rm /System/Library/Caches/com.apple.coresymbolicationd/data

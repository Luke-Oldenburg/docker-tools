#!/bin/bash
docker rm -vf $(docker ps -a -q)
docker rmi -f $(docker images -a -q)
docker system prune -a --volumes
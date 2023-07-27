#!/bin/bash

docker run --name ubuntu-vm -v $PWD/share:/root/share -it ubuntu:20.04 bash
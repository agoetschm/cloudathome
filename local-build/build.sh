#!/bin/bash

docker build omgwtfssl -t omgwtfssl
docker build gitea -t gitea --build-arg ARCH=$ARCH

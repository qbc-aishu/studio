#!/usr/bin/env bash

set -e
set -x

docker compose -f docker-compose.tidb.yaml down -v || true

if [[ $1 == "stop" ]]; then
    exit
fi

docker compose -f docker-compose.tidb.yaml up -d

mycli -u root -P 4000 -e "SET PASSWORD FOR 'root'@'%' = PASSWORD('password');"
mycli -u root -P 4000 -p password -e "CREATE DATABASE deploy;"

#!/bin/bash

docker compose down --remove-orphans

# Remove existing hadoop containers (e.g., from exercise03)
for container in namenode resourcemanager datanode nodemanager historyserver jupyter; do
  if docker container inspect "$container" >/dev/null 2>&1; then
    # Try graceful shutdown first, then remove. Force-remove only if needed.
    docker stop -t 10 "$container" >/dev/null 2>&1 || true
    docker rm "$container" >/dev/null 2>&1 || docker rm -f "$container" >/dev/null 2>&1
  fi
done

docker compose build hadoop-base
docker compose up $1

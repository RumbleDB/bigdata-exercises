#!/usr/bin/env bash

SCRIPT_DIR="$(cd $(dirname "${BASH_SOURCE[0]}"); pwd -P)"

alias docker-compose="docker-compose --env-file \"${SCRIPT_DIR}/.env\""

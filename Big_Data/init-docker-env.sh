#!/usr/bin/env bash

SCRIPT_DIR="$(cd $(dirname "${BASH_SOURCE[0]}"); pwd -P)"

(
    echo -n "HOST_UID="
    id -u
    echo -n "HOST_GID="
    id -g
) > "${SCRIPT_DIR}/.env"

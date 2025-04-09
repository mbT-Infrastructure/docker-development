#!/usr/bin/env bash

export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DOCKER_HOST="unix:///${XDG_RUNTIME_DIR}/docker.sock"

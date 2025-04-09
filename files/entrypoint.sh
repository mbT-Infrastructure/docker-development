#!/usr/bin/env bash
set -e -o pipefail

chown --recursive user /media/user

usermod --remove --groups "$USER_GROUPS" user
usermod --append --groups "$USER_GROUPS" user

echo "start docker deamon"

su user --command "XDG_RUNTIME_DIR=/run/user/$(id -u user) dockerd-rootless.sh &> /dev/null" &

exec "$@"

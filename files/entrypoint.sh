#!/usr/bin/env bash
set -e -o pipefail

if [[ -z "$AI_BASE_URL" ]]; then
    export AI_BASE_URL="$AI_API_URL"
fi

chown --recursive user /media/user

usermod --remove --groups "$USER_GROUPS" user
usermod --append --groups "$USER_GROUPS" user

echo "start docker deamon"

su user --command "XDG_RUNTIME_DIR=/run/user/$(id -u user) dockerd-rootless.sh &> /dev/null" &

exec "$@"

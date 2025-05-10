#!/usr/bin/env bash
set -e -o pipefail

if [[ -z "$AI_BASE_URL" ]]; then
    export AI_BASE_URL="$AI_API_URL"
fi

if [[ "$(id --user)" -eq 0 ]]; then
    chown --recursive user /media/user
    usermod --remove --groups "$USER_GROUPS" user
    usermod --append --groups "$USER_GROUPS" user

    su user --command "XDG_RUNTIME_DIR=/run/user/$(id -u user) dockerd-rootless.sh &> /dev/null" &
else
    export "XDG_RUNTIME_DIR=/run/user/$(id -u)"
    dockerd-rootless.sh &> /dev/null &
fi

disown -h

exec "$@"

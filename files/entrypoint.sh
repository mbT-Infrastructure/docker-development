#!/usr/bin/env bash
set -e -o pipefail

if [[ -n "$AI_API_URL" ]]; then
    replace-vars.sh /media/user/.codex/config-template.toml > /media/user/.codex/config.toml
fi

if [[ "$(id --user)" -eq 0 ]]; then
    chown --recursive user /media/user
    usermod --remove --groups "$USER_GROUPS" user
    usermod --append --groups "$USER_GROUPS" user

    rm -f "/run/user/$(id -u user)/docker.pid"
    su user --command "XDG_RUNTIME_DIR=/run/user/$(id -u user) dockerd-rootless.sh &> /dev/null" &
else
    export "XDG_RUNTIME_DIR=/run/user/$(id -u)"
    dockerd-rootless.sh &> /dev/null &
fi

disown -h

exec "$@"

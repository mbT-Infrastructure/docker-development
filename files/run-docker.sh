#!/usr/bin/env bash
set -e -o pipefail

SCRIPT_NAME="$(basename "$0")"

if [[ "$EXTERNAL_DOCKER" == "true" ]]; then
    echo "[$SCRIPT_NAME] External Docker, sleeping forever." >&2
    sleep infinity
fi


rm -f "/run/user/$(id -u user)/docker.pid"

if [[ "$(id --user)" -eq 0 ]]; then
    exec su user --command \
        "XDG_RUNTIME_DIR=/run/user/$(id -u user) dockerd-rootless.sh"
else
    export "XDG_RUNTIME_DIR=/run/user/$(id -u)"
    exec dockerd-rootless.sh
fi

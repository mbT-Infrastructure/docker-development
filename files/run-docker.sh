#!/usr/bin/env bash
set -e -o pipefail

rm -f "/run/user/$(id -u user)/docker.pid"

if [[ "$(id --user)" -eq 0 ]]; then
    exec su user --command \
        "XDG_RUNTIME_DIR=/run/user/$(id -u user) dockerd-rootless.sh"
else
    export "XDG_RUNTIME_DIR=/run/user/$(id -u)"
    exec dockerd-rootless.sh
fi

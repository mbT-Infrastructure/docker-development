#!/usr/bin/env bash
set -e -o pipefail



if [[ "$EUID" -eq 0 ]]; then
    usermod --groups "$USER_GROUPS" user
    if [[ -z "$DOCKER_HOST" ]]; then
        DOCKER_HOST_TEMPLATE="unix://\${XDG_RUNTIME_DIR}/docker.sock"
        DOCKER_HOST="unix:///run/user/1000/docker.sock"
    else
        EXTERNAL_DOCKER="true"
        DOCKER_HOST_TEMPLATE="$DOCKER_HOST"
        export EXTERNAL_DOCKER
    fi
    cat <<EOF > /etc/profile.d/env-development.sh
#!/usr/bin/env bash

LANG="$LANG"
XDG_RUNTIME_DIR="/run/user/\$(id -u)"
DOCKER_HOST="$DOCKER_HOST_TEMPLATE"

export DOCKER_HOST LANG XDG_RUNTIME_DIR
EOF
fi

XDG_RUNTIME_DIR="/run/user/$(id -u)"
if [[ -z "$DOCKER_HOST" ]]; then
    DOCKER_HOST="unix://${XDG_RUNTIME_DIR}/docker.sock"
fi
export DOCKER_HOST XDG_RUNTIME_DIR

exec "$@"

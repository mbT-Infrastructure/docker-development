#!/usr/bin/env bash
set -e -o pipefail

if [[ "$EUID" -eq 0 ]]; then
    usermod --groups "$USER_GROUPS" user

    cat <<EOF > /etc/profile.d/env-development.sh
#!/usr/bin/env bash

LANG="$LANG"
DOCKER_HOST="unix:///\${XDG_RUNTIME_DIR}/docker.sock"
XDG_RUNTIME_DIR="/run/user/\$(id -u)"

export DOCKER_HOST LANG XDG_RUNTIME_DIR
EOF
fi

exec "$@"

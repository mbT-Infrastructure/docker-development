#!/usr/bin/env bash
set -e -o pipefail

echo "Connect to the Container via ssh as User user"
echo "Authorized public keys:"
echo "$AUTHORIZED_PUBLIC_KEYS"
mkdir --parents /app/ssh
echo "$AUTHORIZED_PUBLIC_KEYS" > /app/ssh/authorized_keys

if [[ -z "$HOST_KEY" ]]; then
    echo "Host key or host public key not specified."
    public-key-infrastructure.sh --create ssh-key
    rm ssh-key.pub
    mv ssh-key /app/ssh/host_key
else
    echo "$HOST_KEY" > /app/ssh/host_key
    chmod 0600 /app/ssh/host_key
fi

exec /usr/sbin/sshd -D -e

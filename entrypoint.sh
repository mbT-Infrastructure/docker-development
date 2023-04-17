#!/usr/bin/env bash
set -e

echo "Connect to the Container via ssh as User user"
echo "Authorized keys:"
echo "$PUBLIC_KEYS"
mkdir --parents /app/ssh
echo "$PUBLIC_KEYS" > /app/ssh/authorized_keys

chown --recursive user /media/user

echo "start docker deamon"
dockerd &> /var/log/dockerd &

exec "$@"

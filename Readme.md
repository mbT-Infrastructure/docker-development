# Development image

This Docker image contains tools for development.

It starts a ssh deamon for the user `user`.


## Environment variables

- `AUTHORIZED_PUBLIC_KEYS`
    - Public keys with access to the ssh server. For example `ssh-rsa AAAAB3Nz... user@example.madebytimo.de`.
- `HOST_KEY`
    - Host key to use for the ssh server.


## Volumes

- `/media/user`
    - The home directory of the development user.


## Development

To build and run for development run:
```bash
docker compose --file docker-compose-dev.yaml up --build
```

To build the image locally run:
```bash
./docker-build.sh
```

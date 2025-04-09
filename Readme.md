# development image

This Docker image contains tools for development.

It starts a ssh deamon for the user `user`.

## Installation

1. Pull from [Docker Hub], download the package from [Releases] or build using `builder/build.sh`

## Usage

This Container image extends the [builder image].

### Environment variables

-   `AUTHORIZED_PUBLIC_KEYS`
    -   Public keys with access to the ssh server. For example
        `ssh-rsa AAAAB3Nz... user@example.madebytimo.de`.
-   `HOST_KEY`
    -   Host key to use for the ssh server.
-   `USER_GROUPS`
    -   Comma seperated list of groups the user will be member of. The user will be removed from
        groups not listed. Defaults to `docker,sudo`.

### Volumes

-   `/media/user`
    -   The home directory of the development user.

## Development

To run for development execute:

```bash
docker compose --file docker-compose-dev.yaml up --build
```

[builder image]: https://github.com/mbT-Infrastructure/docker-builder
[Docker Hub]: https://hub.docker.com/r/madebytimo/development
[Releases]: https://github.com/mbT-Infrastructure/docker-development/releases

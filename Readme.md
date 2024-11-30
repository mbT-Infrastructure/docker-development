# development image

This image contains ...

It does ...

## Installation

1. Pull from [Docker Hub], download the package from [Releases] or build using `builder/build.sh`

## Usage

This Container image extends the [base image]. Make sure to also configure environment variables,
ports and volumes from that image.

### Command line flags

-   `--output PATH`
    -   The output path.

### Environment variables

-   `VARIABLE`
    -   Set to `true` to enable ..., default: ``.

### Volumes

-   `/media/volume`
    -   The input and output directory of the files to ...

## Development

To run for development execute:

```bash
docker compose --file docker-compose-dev.yaml up --build
```

[base image]: https://github.com/mbT-Infrastructure/docker-base
[Docker Hub]: https://hub.docker.com/r/madebytimo/development
[Releases]: https://github.com/madebytimo/docker-development/releases

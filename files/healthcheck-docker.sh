#!/usr/bin/env bash
set -e -o pipefail

docker system info &> /dev/null || exit 1

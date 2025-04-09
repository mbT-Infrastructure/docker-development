#!/usr/bin/env bash
set -e -o pipefail

nc -z localhost 22 || exit 1

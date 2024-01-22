#!/usr/bin/env bash

docker run --rm -i -a stdin -a stdout -a stderr \
  -v "compose-example_studio_data:/var/data" \
  ghcr.io/benthosdev/benthos-studio-shost '--db=/var/data/db' "$@"

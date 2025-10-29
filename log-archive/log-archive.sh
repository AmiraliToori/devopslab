#!/usr/bin/env bash

INPUT_DIR="$1"
DEST_DIR="$2"

if ! [ -d "$INPUT_DIR" ]; then
  printf "Invalid argument: The input must be a directory.\n"
  exit 1
fi

if [ -z "$DEST_DIR"]; then
  DEST_DIR="."
fi

tar -czvf $DEST_DIR/logs_archive_$(date "+%Y%m%d_%H%M%S").tar.gz $INPUT_DIR

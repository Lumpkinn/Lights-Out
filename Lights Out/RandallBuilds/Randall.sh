#!/bin/sh
printf '\033c\033]0;%s\a' Randall
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Randall.x86_64" "$@"

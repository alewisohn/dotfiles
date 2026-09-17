#!/usr/bin/env bash

set -e

cd "$(dirname "$0")"

if ! command -v pacman >/dev/null 2>&1; then
  echo "This profile expects pacman (Omarchy/Arch Linux)." >&2
  exit 1
fi

missing=()
while IFS= read -r package
do
  [ -n "$package" ] || continue
  case "$package" in \#*) continue ;; esac

  if ! pacman -Q "$package" >/dev/null 2>&1; then
    missing+=("$package")
  fi
done < packages.txt

if [ "${#missing[@]}" -eq 0 ]; then
  echo "› Omarchy packages already installed"
  exit 0
fi

echo "› installing Omarchy packages: ${missing[*]}"
sudo pacman -S --needed -- "${missing[@]}"

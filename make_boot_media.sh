#!/bin/bash

set -ex

disk="$1"

alpine_release='3.15'
archive="alpine-rpi-$alpine_release.0-aarch64.tar.gz"

curl \
  "https://dl-cdn.alpinelinux.org/alpine/v$alpine_release/releases/aarch64/$archive" \
  -o "$archive"

sudo sfdisk --delete "$disk"
sudo wipefs --all "$disk"

sudo sfdisk "$disk" <<EOF
  ,200M,c,*
  ,,
EOF

read -ra parts < <(lsblk "$disk" --json | jq -r '[.blockdevices[0].children |= sort_by(."maj:min") | .blockdevices[0].children[].name] | @sh' | tr -d \')

boot_part="/dev/${parts[0]}"
persist_part="/dev/${parts[1]}"

sudo mkfs.fat -F32 "$boot_part"
sudo mkfs.ext4 "$persist_part"

mkdir boot
sudo mount "$boot_part" boot

sudo tar -zxvf "$archive" -C boot

sync

#!/bin/sh

set -ex

disk="$1"

boot_part="${disk}1"
persist_part="${disk}2"

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

sudo mkfs.fat -F32 "$boot_part"
sudo mkfs.ext4 "$persist_part"

mkdir boot
sudo mount "$boot_part" boot

sudo tar -zxvf "$archive" -C boot

sync

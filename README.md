# Raspberry Pi Alpine Linux install scripts [![Code Quality](https://github.com/DanNixon/alpine-raspberry-pi-install/actions/workflows/code_quality.yml/badge.svg?branch=main)](https://github.com/DanNixon/alpine-raspberry-pi-install/actions/workflows/code_quality.yml)

Simple scripts to automate creation of boot media for a diskless Alpine Linux install on the Raspberry Pi.

## Usage

- `./make_boot_media.sh /dev/mmcblk0`
- (make any additional changes, e.g. setting user config)
- `./umount_boot_media.sh`

## Additional resources

- https://wiki.alpinelinux.org/wiki/Raspberry_Pi
- https://github.com/mesca/alpine_headless

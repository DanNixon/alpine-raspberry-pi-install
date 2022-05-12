#!/bin/sh

set -ex

sync

sudo umount boot
rmdir boot

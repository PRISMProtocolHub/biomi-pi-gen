#!/bin/bash -e

install -m 644 files/cmdline.txt "${ROOTFS_DIR}/boot/"
install -m 644 files/config.txt "${ROOTFS_DIR}/boot/"

# Use raspi-config to enable the serial shell
on_chroot << EOF
raspi-config nonint do_serial 0
EOF
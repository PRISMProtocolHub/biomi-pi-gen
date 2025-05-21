#!/bin/bash -e

BT_CONFIG_DIR="${ROOTFS_DIR}/etc/bluetooth"

mkdir -p "${BT_CONFIG_DIR}"

install -m 644 files/pins "${BT_CONFIG_DIR}/"

on_chroot << EOF
  echo "@reboot sudo bt-agent -c DisplayOnly -p /etc/bluetooth/pins" >> /var/spool/cron/crontabs/pi
  systemctl enable bluetooth.service
EOF

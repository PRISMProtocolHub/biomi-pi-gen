#!/bin/bash -e

BT_CONFIG_DIR="${ROOTFS_DIR}/etc/bluetooth"

mkdir -p "${BT_CONFIG_DIR}"

install -m 644 files/pins "${BT_CONFIG_DIR}/pins"

on_chroot << EOF
  chown root:root /etc/bluetooth/pins
  chmod 644 /etc/bluetooth/pins

  echo "@reboot sudo bt-agent -c DisplayOnly -p /etc/bluetooth/pins" >> /var/spool/cron/crontabs/pi
EOF

on_chroot << EOF
  systemctl enable bluetooth.service
EOF
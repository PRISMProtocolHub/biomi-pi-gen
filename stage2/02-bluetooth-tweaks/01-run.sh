#!/bin/bash -e
mkdir -p "${ROOTFS_DIR}/etc/bluetooth"

install -m 644 files/pins "${ROOTFS_DIR}/etc/bluetooth/"

on_chroot << EOF
  mkdir -p /var/spool/cron/crontabs
  echo "@reboot sudo bt-agent -c DisplayOnly -p /etc/bluetooth/pins" >> /var/spool/cron/crontabs/pi

  chown pi:crontab /var/spool/cron/crontabs/pi
  chmod 600 /var/spool/cron/crontabs/pi

  systemctl enable bluetooth.service
EOF

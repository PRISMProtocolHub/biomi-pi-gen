#!/bin/bash -e

# Up to bullseye, dhcpcd and wpa_supplicant read wpa_supplicant.conf directly:
# the import would delete or rename it and cut Wi-Fi.
case "${RELEASE}" in
	buster | bullseye)
		log "Skipping biomi-wifi-import: ${RELEASE} does not use NetworkManager"
		exit 0
		;;
esac

install -m 755 files/biomi-wifi-import "${ROOTFS_DIR}/usr/local/sbin/"
install -m 644 files/biomi-wifi-import.service "${ROOTFS_DIR}/etc/systemd/system/"

on_chroot << EOF2
systemctl enable biomi-wifi-import.service
EOF2

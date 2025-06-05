#!/bin/bash -e

# Use raspi-config to enable the serial shell
on_chroot << EOF
	SUDO_USER="${FIRST_USER_NAME}" raspi-config nonint do_serial 0
EOF

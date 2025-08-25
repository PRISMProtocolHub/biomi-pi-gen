#!/bin/bash -e

echo "=== UART Custom Configuration  ==="
echo "enable_uart=1" >> "${ROOTFS_DIR}/boot/firmware/config.txt"

sed -i 's/console=serial0,[0-9]\+\s*//g' "${ROOTFS_DIR}/boot/firmware/cmdline.txt"

echo "=== UART customized ==="
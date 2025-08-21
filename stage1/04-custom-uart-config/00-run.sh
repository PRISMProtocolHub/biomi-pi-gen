#!/bin/bash -e

echo "=== UART Custom Configuration  ==="
echo "enable_uart=1" >> "${ROOTFS_DIR}/boot/firmware/config.txt"

sed -i 's/console=serial0,[0-9]\+\s*//g' "${ROOTFS_DIR}/boot/firmware/cmdline.txt"
sed -i 's/console=ttyAMA0,[0-9]\+\s*//g' "${ROOTFS_DIR}/boot/firmware/cmdline.txt"

on_chroot << 'EOF'
systemctl disable serial-getty@ttyAMA0.service 2>/dev/null || true
usermod -a -G dialout pi
EOF

echo "=== UART customized ==="
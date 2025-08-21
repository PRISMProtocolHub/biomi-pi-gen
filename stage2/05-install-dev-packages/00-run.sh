#!/bin/bash -e

echo "=== install camera custom config imx708_wide_biomi_custom.json ==="
install -v -m 644 files/imx708_wide_biomi_custom.json "${ROOTFS_DIR}/usr/share/libcamera/ipa/rpi/vc4/"
#!/bin/bash -e

# Installs the camera stack at the versions of the firmware builder image, after
# 01-sys-tweaks installed the latest ones (see files/biomi-camera.pref), and fails
# the build when the result differs at this point: a green build with another
# libcamera ships a camera that crashes. Later apt runs (export's dist-upgrade)
# keep these versions through the pin.
set -o pipefail
POOL=http://archive.raspberrypi.com/debian/pool/main
DEBS="${ROOTFS_DIR:?}/tmp/biomi-camera"

rm -rf "${DEBS}"
mkdir -p "${DEBS}"
while read -r sum path; do
	deb="$(basename "${path}")"
	curl -fsS --retry 3 -o "${DEBS}/${deb}" "${POOL}/${path}"
	echo "${sum}  ${DEBS}/${deb}" | sha256sum -c --quiet -
done < files/biomi-camera.sha256

install -m 644 files/biomi-camera.pref "${ROOTFS_DIR}/etc/apt/preferences.d/biomi-camera.pref"

on_chroot << CHROOT
apt-get install -y --no-install-recommends --allow-downgrades /tmp/biomi-camera/*.deb
CHROOT
rm -rf "${DEBS}"

# The pref names each package with its pinned version: every one must be installed at it.
checked=0
while read -r package version; do
	status="$(on_chroot <<< "dpkg-query -W -f='\${Status} \${Version}' ${package}" 2>/dev/null || true)"
	if [ "${status}" != "install ok installed ${version}" ]; then
		echo "${package}: '${status:-not installed}', expected ${version}" >&2
		exit 1
	fi
	checked=$((checked + 1))
done < <(awk '/^Package:/ { $1 = ""; packages = $0 } /^Pin: version/ { n = split(packages, p, " "); for (i = 1; i <= n; i++) print p[i], $3 }' \
	files/biomi-camera.pref)
# Same packages in both lists: a deb installed without its pin, or a pin without its deb.
if [ "${checked}" -ne "$(wc -l < files/biomi-camera.sha256)" ]; then
	echo "files/biomi-camera.pref pins ${checked} packages, files/biomi-camera.sha256 lists $(wc -l < files/biomi-camera.sha256)" >&2
	exit 1
fi

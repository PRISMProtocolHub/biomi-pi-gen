#!/bin/bash -e

echo "Install pdm for ${FIRST_USER_NAME}..."
on_chroot << EOF
    su - ${FIRST_USER_NAME} -c "curl -sSLO https://pdm-project.org/install-pdm.py"
    su - ${FIRST_USER_NAME} -c "curl -sSL https://pdm-project.org/install-pdm.py.sha256 | shasum -a 256 -c -"
    su - ${FIRST_USER_NAME} -c "python3 install-pdm.py"
    su - ${FIRST_USER_NAME} -c "export PATH=/home/${FIRST_USER_NAME}/.local/bin:$PATH"
EOF
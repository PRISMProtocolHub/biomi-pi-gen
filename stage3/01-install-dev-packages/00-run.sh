#!/bin/bash -e

on_chroot << EOF

    # intall pdm
    su - pi -c "pipx install pdm"
    su - pi -c "pipx ensurepath --force"

    # Add pipx to path
    echo 'export PATH="$PATH:$HOME/.local/bin"' >> /home/pi/.bashrc

EOF
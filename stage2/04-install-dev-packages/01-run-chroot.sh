#!/bin/bash -e

sudo -u pi bash -c 'curl -sSL https://pdm-project.org/install-pdm.py | python3 -'
echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/pi/.bashrc
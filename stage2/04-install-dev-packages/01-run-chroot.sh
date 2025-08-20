#!/bin/bash -e

pip install --user pipx
python3 -m venv myproject

sudo -u pi bash -c 'curl -sSL https://pdm-project.org/install-pdm.py | python3 -'
sudo -u pi bash -c 'echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.bashrc'
#!/bin/bash
set -euxo pipefail


# --- base packages ---
sudo dnf -y update || true
sudo dnf -y install docker git
sudo systemctl enable --no

#!/bin/bash
{
  set -euo pipefail

  source ./install/nix.sh
  source ./install/nix-darwin.sh
  source ./install/configs.sh
  source ./install/system.sh

  install_nix
  install_nix_darwin
  install_my_configs
  build
}

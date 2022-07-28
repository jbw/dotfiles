#!/bin/bash

install_nix_darwin() {
  if command -v darwin-rebuild &>/dev/null; then
    echo "Already installed Darwin Nix."
  else
    echo "Installing Dawrin Nix..."
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer ./result/bin/darwin-installer
  fi
}

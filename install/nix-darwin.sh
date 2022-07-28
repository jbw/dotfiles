#!/bin/bash

install_nix_darwin() {
  if command -v darwin-rebuild &>/dev/null; then
    echo "Already installed Nix Darwin."
  else
    echo "Installing Nix Darwin..."
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer ./result/bin/darwin-installer

    sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.backup-before-nix-darwin
  fi
}

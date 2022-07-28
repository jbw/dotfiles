#!/bin/bash

install_nix() {
  if command -v nix &>/dev/null; then
    echo "Nix is already installed."
    exit 1
  else
    echo "Installing Nix..."
    curl -L https://nixos.org/nix/install | bash
  fi
}

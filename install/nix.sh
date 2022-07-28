#!/bin/bash

install_nix() {
  if command -v nix &>/dev/null; then
    echo "Already installed Nix."
  else
    echo "Installing Nix..."
    curl -L https://nixos.org/nix/install | bash
  fi
}

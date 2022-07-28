#!/bin/bash

install_my_configs() {
  repository="https://github.com/jbw/dotfiles.git"
  target="$HOME/.nixpkgs"

  if $JBW_DOTFILES_FRESH_CONFIG_INSTALL; then
    echo "Installing configs from fresh..."
    rm -rf "$target"
  fi

  if cat "$target/.git/config" &>/dev/null; then
    echo "Already installed JBW's configs."
  else
    echo "Installing JBW's configs..."
    rm -rf "$target"
    git clone -b "nix-darwin" "$repository" "$target"
  fi
}

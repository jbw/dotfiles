#! /bin/bash
{
  set -euo pipefail

  install_nix() {
    if command -v nix &>/dev/null; then
      echo "Already installed Nix."
    else
      echo "Installing Nix..."
      printf n\ny\ny\ny\ny | sh <(curl -L https://nixos.org/nix/install) --daemon

      # Update local shell
      source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

    fi
  }

  install_nix_darwin() {
    if command -v darwin-rebuild &>/dev/null; then
      echo "Already installed Nix Darwin."
    else
      echo "Installing Nix Darwin..."
      nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer --out-link /tmp/nix-darwin
      sudo mv /etc/nix/nix.conf /etc/nix/nix.conf.backup-before-nix-darwin
      printf "n\ny\ny\ny\ny" | /tmp/nix-darwin/bin/darwin-installer
    fi
  }

  install_my_configs() {
    repository="https://github.com/jbw/dotfiles.git"
    target="$HOME/.nixpkgs"

    if [ ! -z ${JBW_DOTFILES_FRESH_CONFIG_INSTALL+x} ]; then
      if [ "$JBW_DOTFILES_FRESH_CONFIG_INSTALL" == "true" ]; then
        echo "Installing configs from fresh..."
        rm -rf "$target"
      fi
    fi

    if cat "$target/.git/config" &>/dev/null; then
      echo "Already installed JBW's configs."
    else
      echo "Installing JBW's configs..."
      rm -rf "$target"
      git clone -b "nix-darwin" "$repository" "$target"
    fi
  }

  build() {
    echo "Building..."

    # Update local shell
    source /nix/var/nix/profiles/default/etc/profile.d/nix.sh

    export NIX_PATH=$HOME/.nix-defexpr/channels:$NIX_PATH
    darwin-rebuild switch -I "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
  }

  install_nix
  install_nix_darwin
  install_my_configs
  build
}

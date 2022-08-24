#! /bin/bash
{
  set -euo pipefail

  # Lifted from https://github.com/kalbasit/shabka/blob/8f6ba74a9670cc3aad384abb53698f9d4cea9233/os-specific/darwin/setup.sh#L22
  sudo_prompt() {
    echo "Please enter your password for sudo authentication"
    sudo -k
    sudo echo "sudo authentication successful!"
    while true; do
      sudo -n true
      sleep 60
      kill -0 "$$" || exit
    done 2>/dev/null &
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
        rm -rf "$target"/* "$target"/.*
        git clone -b "main" "$repository" "$target"
        return
      fi
    fi

    if cat "$target/.git/config" &>/dev/null; then
      echo "Already installed JBW's configs."
    else
      echo "Installing JBW's configs..."
      rm -rf "$target"
      git clone -b "main" "$repository" "$target"
    fi
  }

  build() {

    echo "Building..."

    for filename in shells bashrc zshrc; do
      filepath="/etc/${filename}"
      if [ -f "${filepath}" ] && [ ! -L "${filepath}" ]; then
        sudo mv "${filepath}" "${filepath}.backup-before-nix-darwin"
      fi
    done

    # Update local shell
    set +u
    source /etc/static/bashrc
    set -u

    # Rebuild
    export NIX_PATH=$HOME/.nix-defexpr/channels:$NIX_PATH
    darwin-rebuild switch -I "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
  }

  sudo_prompt
  install_nix_darwin
  install_my_configs
  build
}

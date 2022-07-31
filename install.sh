#! /bin/bash
{
  set -euo pipefail

  # Lifted from https://github.com/kalbasit/shabka/blob/8f6ba74a9670cc3aad384abb53698f9d4cea9233/os-specific/darwin/setup.sh#L22
  sudo_prompt() {
    echo "Please enter your password for sudo authentication"
    sudo -k
    sudo echo "sudo authenticaion successful!"
    while true; do
      sudo -n true
      sleep 60
      kill -0 "$$" || exit
    done 2>/dev/null &
  }

  install_command_line_tools() {
    # Unattended installation of Command Line Tools
    # Found on apple.stackexchange.com at https://apple.stackexchange.com/questions/107307/how-can-i-install-the-command-line-tools-completely-from-the-command-line/195963#195963
    # Homebrew uses a similar technique https://github.com/Homebrew/install/blob/878b5a18b89ff73f2f221392ecaabd03c1e69c3f/install#L297
    xcode-select -p >/dev/null || {
      touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
      CLT=$(softwareupdate -l |
        grep "\*.*Command Line Tools" |
        head -n 1 |
        awk -F ":" '{print $2}' |
        sed -e 's/^ *//' |
        tr -d '\n')
      softwareupdate -i "$CLT" --verbose
      rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    }
    echo "Command Line Tools are installed at $(xcode-select -p)"
  }

  install_nix() {
    if command -v nix &>/dev/null; then
      echo "Already installed Nix."
    else
      echo "Installing Nix..."
      printf n\ny\ny\ny\ny | sh <(curl -L https://nixos.org/nix/install) --daemon

      # Update local shell
      set +u
      source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      set -u
      nix-shell -p nix-info --run "nix-info -m"
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
    export NIX_PATH=$HOME/.nix-defexpr/channels:$NIX_PATH
    darwin-rebuild switch -I "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
  }

  sudo_prompt
  install_command_line_tools
  install_nix
  install_nix_darwin
  install_my_configs
  build
}

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

  sudo_prompt
  install_command_line_tools
  install_nix

}

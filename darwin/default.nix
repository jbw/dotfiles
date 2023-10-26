{  pkgs, config, ... }:

{

  homebrew.enable = true;
  homebrew.global.brewfile = true;
  homebrew.onActivation.autoUpdate = true;
  homebrew.onActivation.upgrade = true;
  homebrew.onActivation.cleanup = "zap";


  homebrew.taps = [
    "homebrew/core"
    "homebrew/cask"
  ];

  homebrew.casks = pkgs.callPackage ./casks.nix {};
  homebrew.brews = pkgs.callPackage ./brews.nix {};


  system.activationScripts.postUserActivation.text = ''
    echo "Upgrading Homebrew Casks..."
    ${config.homebrew.brewPrefix}/brew upgrade
  '';

  imports = [ ./macos.nix ];
}

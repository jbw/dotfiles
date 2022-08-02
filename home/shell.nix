{ config, pkgs, ... }:

let shellAliases = { cat = "bat"; };
in {
  home.packages = with pkgs; [ fzf zoxide ];

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
  };
}

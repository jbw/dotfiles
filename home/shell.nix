{ config, pkgs, ... }:

let shellAliases = { cat = "bat"; };
in {
  home.packages = with pkgs; [ fzf zoxide starship ];

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
  };
}

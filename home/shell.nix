{ config, pkgs, ... }:

let shellAliases = { cat = "bat"; };
in {
  home.packages = with pkgs; [ fzf zoxide ];

  programs.zoxide = {
    enable = true;
    options = [ "--cmd j" ];
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
  };

  programs.starship = { enable = true; };
}

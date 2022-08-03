{ config, pkgs, ... }:

let shellAliases = { cat = "bat"; };
in {
  home.packages = with pkgs; [
    fzf # fuzzy matches
    zoxide # better cd
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    
    shellInit = ''
      # Initialize homebrew
      eval (/opt/homebrew/bin/brew shellenv)
    '';

    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
  };

  programs.starship = { enable = true; };
}

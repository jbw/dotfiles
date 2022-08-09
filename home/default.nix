{ config, pkgs, ... }:

{
  imports = [ ./shell.nix ];

  home.packages = with pkgs; [

    home-manager # system package manager

    glow # markdown preview

    # CLI tools
    bat # better `cat`
    fd # better `find`
    exa # better `ls`
    htop # better `top`
    mosh # better `ssh`
    procs # better `ps`
    ripgrep # better `grep`
    dogdns # better `dig`
    broot # better `tree`
    duf # better `df`
    du-dust # better `du`
    bottom # better `top`
    tealdeer # rust implementation of `tldr`

    # Development tools
    yarn
    rustup
    go
    fnm

  ];

  home.stateVersion = "20.09";
}

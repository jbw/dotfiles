{ config, pkgs, ... }:

{
  imports = [ ./shell.nix ];

  home.packages = with pkgs; [
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

    # Languages
    yarn
    rustup
    go

    home-manager # system package manager
  ];
}

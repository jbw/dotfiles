{ config, pkgs, ... }:

{
  imports = [ ./git ./shell.nix ];

  home.packages = with pkgs;
    [

      home-manager # system package manager
      hub # git wrapper
      glow # markdown preview
      tokei # code statistics
      neovim # text editor
      wezterm # terminal emulator

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
      diff-so-fancy # better `diff`

      # Development tools
      yarn
      rustup
      go
      fnm
      node

    ] ++ (with nodePackages; [
      # NPM Packages
      neovim # neovim nodejs provider
      prettier # code formatter

    ]) ++ lib.optionals stdenv.isDarwin [
      m-cli # useful macos CLI commands

    ];

  home.stateVersion = "20.09";
}

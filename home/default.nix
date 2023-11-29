{ config, pkgs, ... }:

{
  imports = [ ./git ./shell.nix ];

  home.packages = with pkgs;
    [

      home-manager # system package manager
      hub # git wrapper
      glow # markdown preview
      # tokei # code statistics
      neovim # text editor
      wezterm # terminal emulator

      # CLI tools
      bat # better `cat`
      fd # better `find`
      eza # better `ls`
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
      shellcheck # shell script linter
      neofetch # system info

      # Development tools
      yarn
      rustup
      go
      fnm

      # Ruby
      ruby
      rbenv # ruby version manager
      solargraph # ruby language server
      


    ] ++ (with nodePackages; [
      # NPM Packages
      neovim # neovim nodejs provider
      prettier # code formatter
      jsonlint 

    ]) ++ lib.optionals stdenv.isDarwin [
      m-cli # useful macos CLI commands

    ];

  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}

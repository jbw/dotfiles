{ config, pkgs, ... }:

let
  me = "jbw";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  imports = [ ./darwin <home-manager/nix-darwin> ];

  environment.systemPackages = with pkgs; [ home-manager kitty starship ];

  users.users.${me} = {
    home = "/Users/${me}";
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  home-manager = {
    users.${me} = import ./home;
    useGlobalPkgs = true;
    useUserPackages = false;
  };

  services.nix-daemon.enable = true;
  nix.useDaemon = true;

  system.stateVersion = 4;
}

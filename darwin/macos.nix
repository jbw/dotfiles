{ config, pkgs, ... }:

{
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.finder.CreateDesktop = false;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;

}

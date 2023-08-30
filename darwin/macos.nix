{ config, pkgs, ... }:

{
  # Disable the “Are you sure you want to open this application?” dialog
  system.defaults.LaunchServices.LSQuarantine = false;

  # Save to disk (not to iCloud) by default
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = true;

  # Keyboard
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;

  # Finder
  system.defaults.finder.CreateDesktop = false;
  system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
  system.defaults.finder.AppleShowAllExtensions = true;

  # Dock
  system.defaults.dock.autohide = true;
  system.defaults.dock.tilesize = 46;
}

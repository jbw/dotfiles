#!/bin/bash

build() {
  echo "Building..."

  export NIX_PATH=$HOME/.nix-defexpr/channels:$NIX_PATH
  darwin-rebuild switch -I "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix"
}

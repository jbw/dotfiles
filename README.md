# dotfiles

## Install

### Install Nix

```sh
curl -fsSL https://raw.githubusercontent.com/jbw/dotfiles/main/install_nix.sh | bash
```

### Install configs

```sh
curl -fsSL https://raw.githubusercontent.com/jbw/dotfiles/main/install_configs.sh | bash
```

### Troubleshooting

* Check nix-info

```sh
nix-shell -p nix-info --run "nix-info -m"
```

* Do a fresh install

```sh
export JBW_DOTFILES_FRESH_CONFIG_INSTALL=true
curl -fsSL https://raw.githubusercontent.com/jbw/dotfiles/main/install_configs.sh | bash
```

* Use `nixpkg` unstable with `home-manager` master

I'm tracking `home-manager@master` and `nixpkgs-unstable`. They both need to track stable or unstable. 

```sh
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
sudo nix-channel --update
```

* Update `nix-darwin`

```
nix-channel --update darwin 
darwin-rebuild changelog
```

* Update packages

For example, installing neovim
```
nix-env -iA nixpkgs.neovim
```

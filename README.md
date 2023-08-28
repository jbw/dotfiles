# dotfiles

## Install

:warning:

### Step 1

```sh
curl -fsSL https://raw.githubusercontent.com/jbw/dotfiles/main/install_nix.sh | bash
```

### Step 2

```sh
curl -fsSL https://raw.githubusercontent.com/jbw/dotfiles/main/install_configs.sh | bash
```

## Manual Steps

### home-manager

```
nix-channel --add https://github.com/nix-community/home-manager/archive/refs/heads/release-22.11.tar.gz home-manager

nix-channel --update --verbose
```


### Troubleshooting

1. Check nix-info

```
nix-shell -p nix-info --run "nix-info -m"
```

2. Do a fresh install
```
export JBW_DOTFILES_FRESH_CONFIG_INSTALL=true
```

3. Use nixpkg unstable with home-manager master

```
sudo nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
sudo nix-channel --update
```

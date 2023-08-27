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
nix-channel --add https://github.com/nix-community/home-manager/archive/refs/heads/release-22.09.tar.gz home-manager

nix-channel --update --verbose
```

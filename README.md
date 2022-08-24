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
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager

nix-channel --update --verbose
```

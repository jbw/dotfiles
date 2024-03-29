{ config, pkgs, ... }:

let
  shellAliases = {
    cat = "bat --style=plain";
    ls = "eza";

    ll = "ls -la";
    l = "ls -l";

    grep = "ag";
    find = "fd";

    oo = "open .";
    tree = "eza --tree";

    # Git 
    git = "hub";
    # "https://jonsuh.com/blog/git-command-line-shortcuts/"
    ga = "git add";
    gap = "git add --patch";
    gaa = "git add .";
    gaaa = "git add --all";
    gau = "git add --update";
    gb = "git branch";
    gbd = "git branch --delete ";
    gc = "git commit";
    gcm = "git commit --message";
    gcf = "git commit --fixup";
    gco = "git checkout";
    gcob = "git checkout -b";
    gd = "git diff";
    gds = "git diff --staged";
    gda = "git diff HEAD";
    gi = "git init";
    glg = "git log --graph --oneline --decorate --all";
    gld =
      "git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --all";
    glf = "git log -p $1";
    gm = "git merge --no-ff";
    gma = "git merge --abort";
    gmc = "git merge --continue";
    gp = "git pull";
    gpr = "git pull --rebase";
    gr = "git rebase";
    gs = "git status";
    gss = "git status --short";
    gst = "git stash";
    gsta = "git stash apply";
    gstd = "git stash drop";
    gstl = "git stash list";
    gstp = "git stash pop";
    gsts = "git stash save";
  };
in
{
  home.packages = with pkgs; [
    fzf # fuzzy matches, used by gitIdentity script
    zoxide # better cd
  ];

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
  
    initExtra = ''
      # Initialize homebrew
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # Initialize fnm
      eval "$(fnm env --use-on-cd)"

      # Set editor
      EDITOR=lvim

      # export .local/bin
      export PATH="$HOME/.local/bin:$PATH"

      # alt + arrow left/right bindings
      bindkey '[C' forward-word
      bindkey '[D' backward-word

      # cmd + arrow left/right bindings
      bindkey "^[[1;9D" beginning-of-line
      bindkey "^[[1;9C" end-of-line
    '';

  };

  programs.gpg = { enable = true; };

  programs.wezterm = {
    enable = true;

    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require 'wezterm'

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.font = wezterm.font('agave', { weight = 450 })
      config.font_size = 18.0


      config.window_decorations = "RESIZE|MACOS_FORCE_DISABLE_SHADOW"

      config.colors = {
        tab_bar = {
          inactive_tab_edge = 'rgba(0% 0% 0% 0%)',
          background = 'rgba(0% 0% 0% 85%)',
          active_tab = {
            bg_color = 'rgba(0% 0% 0% 85%)',
            fg_color = '#999999'
          },
          inactive_tab = {
            bg_color = 'rgba(0% 0% 0% 85%)',
            fg_color = '#505050'
          },
          new_tab = {
            bg_color = 'rgba(0% 0% 0% 85%)',
            fg_color = '#808080'
          }
        }
      }
      
      config.use_fancy_tab_bar = false
      config.enable_tab_bar = true
      config.tab_bar_at_bottom = true
      config.tab_max_width = 15
      config.hide_tab_bar_if_only_one_tab = true
      config.show_new_tab_button_in_tab_bar = false

      config.initial_rows = 50
      config.initial_cols = 200

      config.audible_bell="Disabled"

      config.send_composed_key_when_left_alt_is_pressed=true
      
      config.color_scheme = 'tokyonight'

      -- Keybindings

      config.keys = {
        {
          key = 'Enter',
          mods = 'SUPER|CTRL',
          action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
        },  
        {
          key = 'Enter',
          mods = 'SUPER',
          action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
        },

      }

      return config

    '';
  };


  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      nodejs = {
        symbol = "⬢";
        style = "bold green";
      };

      rust = {
        symbol = "🦀";
        style = "bold red";
      };

      python = {
        symbol = "🐍";
        style = "bold yellow";
      };

      docker_context = {
        symbol = "🐳";
        style = "bold blue";
      };

      golang = {
        symbol = "🐹";
        style = "bold cyan";
      };

      swift = {
        symbol = "🐦";
        style = "bold yellow";
      };

      kubernetes = {
        symbol = "🐙";
        style = "bold green";
      };

      terraform = {
        symbol = "🏗";
        style = "bold blue";
      };

      helm = {
        symbol = "⛵";
        style = "bold blue";
      };

      aws = {
        symbol = "🌎";
        style = "bold yellow";
        format = "on [$symbol$profile]($style) ";
        region_aliases = {
          "us-east-1" = "🇺🇸 va";
          "us-east-2" = "🇺🇸 oh";
          "us-west-1" = "🇺🇸 ca";
          "us-west-2" = "🇺🇸 or";
          "eu-central-1" = "🇩🇪";
          "eu-west-1" = "🇮🇪";
          "eu-west-2" = "🇬🇧";
          "eu-west-3" = "🇫🇷";

        };
      };

      package = {
        symbol = "📦";
        style = "bold yellow";
      };

      battery = {
        full_symbol = "🔋";
        charging_symbol = "🔌";
        discharging_symbol = "⚡";
        display = [{ threshold = 25; }];
      };

      git_branch = {
        format = " [$symbol$branch]($style) ";
        symbol = "🍣 ";
        style = "bold yellow";
      };

      git_status = {
        conflicted = "⚔️ ";
        ahead = "🏎️ 💨 ×$count";
        behind = "🐢 ×$count";
        diverged = "🔱 🏎️ 💨 ×$ahead_count 🐢 ×$behind_count";
        untracked = "🛤️  ×$count";
        stashed = "📦 ";
        modified = "📝 ×$count";
        staged = "🗃️  ×$count";
        renamed = "📛 ×$count";
        deleted = "🗑️  ×$count";
        style = "bright-white";
        format = "$all_status$ahead_behind";
      };

      git_commit = {
        commit_hash_length = 8;
        style = "bold white";
      };

      hostname = {
        ssh_only = false;
        format = "<[$hostname]($style)>";
        trim_at = "-";
        style = "bold dimmed white";
        disabled = true;
      };

      username = {
        show_always = true;
        format = "[$user]($style)@";
      };

      username = {
        style_root = ''
          bold #e74a98
        '';
        style_user = "bold #b392f0";
      };

      directory = {
        truncation_length = 8;
        truncate_to_repo = true;
        read_only = " 🔒";
        style = "bold #61AFEF";
      };

    };
  };
}

{ config, pkgs, ... }:

let
  shellAliases = {
    cat = "bat --style=plain";
    ls = "exa";

    ll = "ls -la";
    l = "ls -l";

    grep = "ag";
    find = "fd";

    oo = "open .";
    tree = "exa --tree";

    # Git 
    git = "hub";
    # "https://jonsuh.com/blog/git-command-line-shortcuts/"
    ga = "git add";
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
in {
  home.packages = with pkgs; [
    fzf # fuzzy matches
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

    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
  };

  programs.gpg = { enable = true; };

  programs.kitty = {
    enable = true;
    extraConfig = ''
      # vim:fileencoding=utf-8:ft=conf

      scrollback_lines 10000

      # Colours
      ## Special
      background           #1f1b2a
      foreground           #e9e9eb
      cursor               #f783ac
      selection_foreground #1a172e
      selection_background #f783ac
      ## Blacks
      color0 #464669
      color8 #50507a
      ## Reds
      color1 #ff5e5e
      color9 #fb5858
      ## Greens
      color2  #abf160
      color10 #c7fc91
      ## Yellows
      color3  #ffe066
      color11 #ffeba5
      ## Blues
      color4  #9e89fd
      color12 #b3b3ff
      ## Magenta
      color5  #f783ac
      color13 #e599f7
      ## Cyan
      color6  #87edf3
      color14 #a2f5f9
      ## White
      color7  #ffffff
      color15 #e1e1e6

      # Background
      background_opacity 0.975

      # Fonts
      font_family Hasklig Semibold
      italic_font Hasklig Semibold Italic
      bold_font Hasklig Bold
      bold_italic_font Hasklig Bold Italic
      font_size 14
      adjust_line_height 1

      # Window
      #os_window_class i3wmForceTile
      remember_window_size no
      initial_window_width 100c
      initial_window_height 26c
      window_padding_width 4

      # OS title bar
      wayland_titlebar_color system
      macos_titlebar_color system

      # Tab bar
      bell_on_tab yes
      tab_bar_edge bottom
      tab_title_template {index}: {title}
      tab_bar_style powerline
      tab_powerline_style slanted
      focus_follows_mouse no
      active_tab_foreground #464669
      active_tab_background #c2fa88
      active_tab_font_style bold_italic
      inactive_tab_foreground #444
      inactive_tab_background #999
      inactive_tab_font_style normal

      # Key mappings
      map shift+page_up scroll_page_up
      map shift+page_down scroll_page_down
      map ctrl+shift+t new_tab_with_cwd
      map ctrl+shift+enter new_window_with_cwd

      ## Search
      map cmd+f launch --type=overlay --stdin-source=@screen_scrollback zsh -c "fzf --no-sort --no-mouse --exact -i --tac | kitty +kitten clipboard"
      map cmd+/ launch --allow-remote-control kitty +kitten kitty_search/search.py @active-kitty-window-id

      ## macos - make text skipping work with alt
      map alt+left send_text all \x1b\x62
      map alt+right send_text all \x1b\x66

      ## tmux..ish binding
      map ctrl+shift+z toggle_layout stack
      map f1 toggle_layout stack

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

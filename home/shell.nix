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
    gld = "git log --pretty=format:';%h %ad %s'; --date=short --all";
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

    '';

    enableAutosuggestions = true;
    enableCompletion = true;
    history.extended = true;
  };

  programs.starship = {
    enable = true;
    settings = {
      battery = {
        full_symbol = "🔋";
        charging_symbol = "🔌";
        discharging_symbol = "⚡";
      };
      git_branch = {
        format = " [$symbol$branch]($style) ";
        symbol = "🍣 ";
        style = "bold yellow";
      };
      git_status = {
        format = " $symbol$status ";
        symbol = "📦 ";
        style = "bold blue";
      };
      hostname = {
        ssh_only = false;
        format = "<[$hostname]($style)>";
        trim_at = "-";
        style = "bold dimmed white";
        disabled = true;
      };
      git_commit = {
        commit_hash_length = 8;
        style = "bold white";
      };
    };
  };
}

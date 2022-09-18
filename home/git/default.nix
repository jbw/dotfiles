{ config, pkgs, ... }:

{
  home.packages = with pkgs.gitAndTools; [ diff-so-fancy hub tig gh ];

  programs.git = {
    enable = true;
    userName = "Jason Watson";
    userEmail = "hi@jbw.codes";
    package = pkgs.gitAndTools.gitFull;

    signing = {
      key = "7987BDD467C8A6471C0603F8274A76F3F8E95079";
      signByDefault = true;
    };

    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "npm-debug.log*"
      "yarn-debug.log*"
      "yarn-error.log*"
      ".pnpm-debug.log*"
    ];

    aliases = {
      l = "log --pretty=oneline -n 50 --graph --abbrev-commit";
      undo = "reset HEAD~1 --mixed";
      findcommit =
        "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short -S$1; }; f";
      findmessage =
        "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }; f";
    };

    extraConfig = {
      commit.template = builtins.toPath ./git-message;
      hub.protocol = "ssh";

      github.user = "jbw";

      # If no upstream branch is specified, push to the branch with the same
      # name as the current branch
      push.default = "current";

      core = {
        editor = "lvim";
        pager = "diff-so-fancy | less --tabs=4 -RFX";
      };

      interactive.diffFilter = "diff-so-fancy --patch";

      init.defaultBranch = "main";
      pull.rebase = true;
      color.ui = true;

      color.diff-highlight = {
        oldNormal = "red bold";
        oldHighlight = "red bold 52";
        newNormal = "green bold";
        newHighlight = "green bold 22";
      };

      color.diff = {
        meta = "11";
        frag = "magenta bold";
        func = "146 bold";
        commit = "yellow bold";
        old = "red bold";
        new = "green bold";
        whitespace = "red reverse";
      };
    };
  };
}

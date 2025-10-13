{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = "Yukishidzu";
    userEmail = "your.email@example.com";  # CHANGE THIS TO YOUR EMAIL
    
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "code --wait";
      merge.tool = "vscode";
      
      # Better diff algorithm
      diff.algorithm = "patience";
      
      # Reuse recorded resolution
      rerere.enabled = true;
      
      # Color configuration
      color = {
        ui = "auto";
        branch = {
          current = "yellow reverse";
          local = "yellow";
          remote = "green";
        };
        diff = {
          meta = "yellow bold";
          frag = "magenta bold";
          old = "red bold";
          new = "green bold";
        };
        status = {
          added = "yellow";
          changed = "green";
          untracked = "cyan";
        };
      };
    };
    
    # Git aliases
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      visual = "!gitk";
      
      # Useful shortcuts
      l = "log --oneline --graph --decorate";
      ll = "log --oneline --graph --decorate --all";
      s = "status -s";
      
      # Undo commits
      undo = "reset --soft HEAD~1";
      amend = "commit --amend";
      
      # Show files in last commit
      dl = "diff-tree --no-commit-id --name-only -r";
    };
  };
  
  # Enable lazygit
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          lightTheme = false;
          activeBorderColor = [ "#89b4fa" "bold" ];
          inactiveBorderColor = [ "#a6adc8" ];
          optionsTextColor = [ "#89b4fa" ];
          selectedLineBgColor = [ "#313244" ];
          selectedRangeBgColor = [ "#313244" ];
          cherryPickedCommitBgColor = [ "#45475a" ];
          cherryPickedCommitFgColor = [ "#89b4fa" ];
        };
      };
      
      # Custom commands
      customCommands = [
        {
          key = "C";
          command = "git cz";
          description = "commit with commitizen";
          context = "files";
          loadingText = "opening commitizen commit tool";
          subprocess = true;
        }
      ];
    };
  };
}

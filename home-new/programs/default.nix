{ config, pkgs, lib, ... }:

{
  imports = [
    ./kitty.nix
    ./firefox.nix
  ];
  
  # Command-line programs
  programs = {
    # Better cat
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-mocha";
        pager = "less -FR";
      };
    };
    
    # Directory jumper
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    
    # Fuzzy finder
    fzf = {
      enable = true;
      enableFishIntegration = true;
      defaultCommand = "fd --type f --hidden --follow --exclude .git";
      defaultOptions = [
        "--height 40%"
        "--layout=reverse"
        "--border"
        "--margin=1"
        "--padding=1"
      ];
    };
    
    # File finder
    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
        "node_modules/"
        "*.pyc"
      ];
    };
    
    # Search tool
    ripgrep = {
      enable = true;
      arguments = [
        "--max-columns=150"
        "--max-columns-preview"
        "--smart-case"
      ];
    };
    
    # System monitor
    btop = {
      enable = true;
      settings = {
        color_theme = "Catppuccin Mocha";
        theme_background = false;
        vim_keys = true;
        rounded_corners = true;
        graph_symbol = "braille";
        shown_boxes = "cpu mem net proc";
        update_ms = 1000;
      };
    };
    
    # Terminal multiplexer
    tmux = {
      enable = true;
      clock24 = true;
      mouse = true;
      terminal = "screen-256color";
      
      extraConfig = ''
        # Catppuccin theme
        set -g status-style bg=#1e1e2e,fg=#cdd6f4
        set -g window-status-current-style bg=#89b4fa,fg=#1e1e2e
        
        # Better keybindings
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        
        # Split windows
        bind | split-window -h
        bind - split-window -v
      '';
    };
  };
}

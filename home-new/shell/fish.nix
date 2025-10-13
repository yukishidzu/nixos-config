{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    
    shellAliases = {
      # System
      ll = "eza -l --icons";
      la = "eza -la --icons";
      tree = "eza --tree --icons";
      
      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";
      
      # NixOS
      rebuild = "sudo nixos-rebuild switch";
      update = "sudo nixos-rebuild switch --upgrade";
      clean = "sudo nix-collect-garbage -d";
      
      # Development
      py = "python3";
      
      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
    };
    
    functions = {
      # Greeting function
      fish_greeting = {
        body = "
          set_color $fish_color_autosuggestion
          echo \"Welcome to NixOS with Hyprland! 🚀\"
          set_color normal
        ";
      };
      
      # Custom prompt
      fish_prompt = {
        body = "
          set -l last_status $status
          set -l normal (set_color normal)
          set -l status_color (set_color brgreen)
          if test $last_status -ne 0
            set status_color (set_color brred)
          end
          
          echo -n -s (set_color brblue) (prompt_pwd) $normal
          echo -n -s ' ' $status_color '❯' $normal ' '
        ";
      };
    };
    
    interactiveShellInit = ''
      # Disable greeting for clean startup
      set fish_greeting
      
      # Set up colors
      set -U fish_color_normal normal
      set -U fish_color_command 89b4fa
      set -U fish_color_quote a6e3a1
      set -U fish_color_redirection f9e2af
      set -U fish_color_end fab387
      set -U fish_color_error f38ba8
      set -U fish_color_param f2cdcd
      set -U fish_color_selection --background=313244
      set -U fish_color_search_match --background=313244
      set -U fish_color_history_current --background=313244
      set -U fish_color_operator 89b4fa
      set -U fish_color_escape cba6f7
      set -U fish_color_cwd 89b4fa
      set -U fish_color_cwd_root f38ba8
      set -U fish_color_valid_path --underline
      set -U fish_color_autosuggestion 6c7086
      set -U fish_color_user a6e3a1
      set -U fish_color_host 89b4fa
      set -U fish_color_cancel f38ba8
      set -U fish_pager_color_completion f5e0dc
      set -U fish_pager_color_description 6c7086
      set -U fish_pager_color_prefix 89b4fa
      set -U fish_pager_color_progress 6c7086
    '';
  };
  
  # Enable eza for better ls
  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    git = true;
    icons = true;
  };
  
  # Enable starship prompt (optional alternative)
  programs.starship = {
    enable = false;  # Disabled by default, using custom fish prompt
    enableFishIntegration = true;
  };
}

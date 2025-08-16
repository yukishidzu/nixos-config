{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    catppuccin.enable = true;
    
    interactiveShellInit = ''
      # FZF с цветами Catppuccin
      set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --border=rounded --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6ac,pointer:#f5e0dc,marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6ac,hl+:#f38ba8"
      
      # Инициализация starship
      starship init fish | source
    '';
    
    shellAliases = {
      ll = "ls -la";
      la = "ls -la";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos";
      update = "sudo nix flake update /etc/nixos";
      cleanup = "sudo nix-collect-garbage -d";
      test-rebuild = "sudo nixos-rebuild test --flake /etc/nixos";
    };
  };
}

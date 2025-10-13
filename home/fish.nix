{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g theme_color_scheme base16
      set -g theme_nerd_fonts yes
      set -g fish_greeting ""
      # Catppuccin-like prompt with nerd icons (simple)
      function fish_prompt
        set_color brblue; printf "  %s " (prompt_pwd)
        set_color normal; printf "> "
      end
    '';
  };

  # Optional: Starship prompt for richer theming (uncomment to enable)
  # programs.starship = {
  #   enable = true;
  #   enableFishIntegration = true;
  # };
}

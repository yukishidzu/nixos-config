{ config, pkgs, lib, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font.name = "JetBrainsMono Nerd Font";
    font.size = 13;
    settings = {
      background = "#1e1e2e";
      foreground = "#cdd6f4";
      cursor = "#f5e0dc";
      selection_foreground = "#1e1e2e";
      selection_background = "#f5e0dc";
      color0  = "#45475a"; color1  = "#f38ba8"; color2  = "#a6e3a1"; color3  = "#f9e2af";
      color4  = "#89b4fa"; color5  = "#f5c2e7"; color6  = "#94e2d5"; color7  = "#bac2de";
      color8  = "#585b70"; color9  = "#f38ba8"; color10 = "#a6e3a1"; color11 = "#f9e2af";
      color12 = "#89b4fa"; color13 = "#f5c2e7"; color14 = "#94e2d5"; color15 = "#a6adc8";
      background_opacity = "0.95";
      confirm_os_window_close = 0;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
    keyBindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "new_tab";
    };
  };
  # Kitty должен быть в userPackages
  home.packages = with pkgs; [ kitty ];
}

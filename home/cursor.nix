{ config, pkgs, lib, ... }:

{
  # Cursor theme Catppuccin Mocha Blue
  gtk.cursorTheme = {
    name = "Catppuccin-Mocha-Blue-Cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 24;
  };

  # Also set XCURSOR for Wayland/X11
  home.sessionVariables = {
    XCURSOR_THEME = "Catppuccin-Mocha-Blue-Cursors";
    XCURSOR_SIZE = "24";
  };

  # Ensure theme packages present
  home.packages = with pkgs; [ pkgs.catppuccin-cursors.mochaBlue ];
}

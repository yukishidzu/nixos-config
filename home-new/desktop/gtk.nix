{ config, pkgs, lib, ... }:

{
  # GTK theme configuration
  gtk = {
    enable = true;
    
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "blue";
      };
    };
    
    cursorTheme = {
      name = "Catppuccin-Mocha-Blue-Cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
      size = 24;
    };
    
    font = {
      name = "Inter";
      size = 11;
    };
    
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = true
    '';
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-button-images = true;
      gtk-decoration-layout = "appmenu:minimize,maximize,close";
      gtk-enable-animations = true;
      gtk-menu-images = true;
      gtk-primary-button-warps-slider = false;
      gtk-toolbar-style = "GTK_TOOLBAR_BOTH_HORIZ";
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-decoration-layout = "appmenu:minimize,maximize,close";
      gtk-enable-animations = true;
      gtk-primary-button-warps-slider = false;
    };
  };
  
  # Qt theme configuration
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
  
  # Home cursor theme
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Blue-Cursors";
    package = pkgs.catppuccin-cursors.mochaBlue;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };
}

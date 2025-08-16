{ config, pkgs, lib, ... }:

{
  # Красивые темы и иконки
  environment.systemPackages = with pkgs; [
    # Иконки
    papirus-icon-theme
    nordic
    whitesur-icon-theme
    breeze-icons
    hicolor-icon-theme
    
    # GTK темы
    whitesur-gtk-theme
    nordic
    catppuccin-gtk
    adw-gtk3
    
    # QT темы
    qt5.qtbase
    qt6.qtbase
    qtstyleplugins
    qt5ct
    qt6ct
    
    # Дополнительные темы
    arc-theme
    materia-theme
    numix-gtk-theme
    vertex-theme
  ];

  # Настройки GTK
  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-theme-name = "Catppuccin-Mocha";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-font-name = "JetBrainsMono Nerd Font 10";
    };
    gtk4.extraConfig = {
      gtk-theme-name = "Catppuccin-Mocha";
      gtk-icon-theme-name = "Papirus-Dark";
      gtk-font-name = "JetBrainsMono Nerd Font 10";
    };
  };

  # Настройки QT
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      package = pkgs.adwaita-qt;
      name = "adwaita-dark";
    };
  };

  # Настройки для приложений
  environment.variables = {
    GTK_THEME = "Catppuccin-Mocha";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    XCURSOR_THEME = "Papirus-Dark";
    XCURSOR_SIZE = "24";
  };

  # Настройки для XDG
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
}

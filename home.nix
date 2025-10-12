{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./home/shell
    ./home/hyprland
    ./home/programs
    ./home/waybar
  ];

  home = {
    username = "yukishidzu";
    homeDirectory = "/home/yukishidzu";
    stateVersion = "25.05";
  };

  # Глобальная тема Catppuccin
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };

  # Разрешить Home Manager управлять собой
  programs.home-manager.enable = true;

  # Менеджер фоновых служб
  systemd.user.startServices = "sd-switch";

  # Основные настройки XDG
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      templates = "$HOME/Templates";
      publicShare = "$HOME/Public";
    };
  };

  # Переменные окружения
  home.sessionVariables = {
    EDITOR = "cursor";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  services = {
    polkit-gnome-authentication-agent-1.enable = true;
    dunst = {
      enable = true;
      settings = {
        global = {
          width = 300;
          height = 300;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "#89B4FA";
          font = "JetBrainsMono Nerd Font 10";
        };
        urgency_normal = {
          background = "#1E1E2E";
          foreground = "#CDD6F4";
        };
      };
    };
  };

  home.packages = with pkgs; [
    nitrogen
    playerctl
    lshw
    lm_sensors
    liberation_ttf
    dejavu_fonts
  ];
}

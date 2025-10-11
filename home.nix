{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    inputs.nix-colors.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModule
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

  # Глобальная тема Catppuccin с исключениями
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";  # Добавляем accent для единообразия
  };

  # Nix Colors для дополнительных тем (опционально)
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  # Позволяем Home Manager управлять собой
  programs.home-manager.enable = true;

  # Менеджер фоновых служб
  systemd.user.startServices = "sd-switch";

  # Основные настройки XDG
  xdg = {
    enable = true;
    
    # Пути к папкам
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
    # Основные приложения
    EDITOR = "cursor";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    
    # Wayland настройки
    NIXOS_OZONE_WL = "1";  # Для Electron приложений
    MOZ_ENABLE_WAYLAND = "1";  # Для Firefox
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    
    # XDG настройки
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  # Дополнительные сервисы пользователя
  services = {
    # Polkit агент для аутентификации
    polkit-gnome-authentication-agent-1.enable = true;
    
    # Уведомления
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

  # Программы, которые должны запускаться с системой
  home.packages = with pkgs; [
    # Обои и рабочий стол
    nitrogen  # менеджер обоев
    
    # Мультимедиа
    playerctl  # управление медиа
    
    # Системные утилиты
    lshw  # информация о железе
    lm_sensors  # датчики
    
    # Шрифты (дополнительно)
    liberation_ttf
    dejavu_fonts
  ];
}
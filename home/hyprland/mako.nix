{ config, pkgs, lib, ... }:

{
  services.mako = {
    enable = true;
    # Явно отключаем catppuccin для mako
    catppuccin.enable = false;
    
    # Основные настройки
    width = 350;
    height = 150;
    margin = "10";
    padding = "15";
    anchor = "top-right";
    
    # Внешний вид Catppuccin Mocha (настроено вручную)
    backgroundColor = "#1e1e2e";
    textColor = "#cdd6f4";
    borderColor = "#89b4fa";
    borderRadius = 8;
    borderSize = 2;
    
    # Прогресс-бар
    progressColor = "over #313244";
    
    # Иконки
    iconPath = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
    icons = true;
    maxIconSize = 48;
    
    # Шрифт
    font = "JetBrainsMono Nerd Font 11";
    
    # Поведение
    defaultTimeout = 5000;
    ignoreTimeout = true;
    
    # Группировка
    groupBy = "app-name";
    
    # Действия
    actions = true;
    
    # Настройки для разных типов уведомлений
    settings = {      
      # Настройки по уровням важности
      "urgency=low" = {
        border-color = "#6c7086";
        default-timeout = 3000;
      };
      
      "urgency=normal" = {
        border-color = "#89b4fa";
        default-timeout = 5000;
      };
      
      "urgency=critical" = {
        border-color = "#f38ba8";
        default-timeout = 0;
        text-color = "#f38ba8";
      };
      
      # Настройки для конкретных приложений
      "app-name=Spotify" = {
        border-color = "#a6e3a1";
        default-timeout = 3000;
      };
      
      "summary~.*[Bb]attery.*" = {
        border-color = "#f9e2af";
        default-timeout = 10000;
      };
    };
  };
}

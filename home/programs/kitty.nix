{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    catppuccin.enable = true;
    
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;
      
      # Настройки окна
      window_padding_width = 8;
      window_border_width = 1;
      
      # Производительность
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      
      # Курсор
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      
      # Прокрутка
      scrollback_lines = 10000;
      
      # Мышь
      mouse_hide_wait = 3;
      url_color = "#89b4fa";
      url_style = "curly";
      
      # Звук
      enable_audio_bell = false;
      visual_bell_duration = 0;
      
      # Прозрачность
      background_opacity = "0.95";
    };
  };
}

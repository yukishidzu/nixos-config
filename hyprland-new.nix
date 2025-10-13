{ config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # ... ваши существующие настройки ...
      exec-once = [
        "swww init"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "sleep 1 && hyprlock"
      ];
      # биндинг для power-меню исправить если не срабатывает
      bind = [
        "SUPER, ESC, exec, wlogout -p layer-shell"
        "SUPER, L, exec, hyprlock"
      ];
    };
  };

  # Hyprlock Catppuccin Mocha с красивым стилем и анимацией
  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      # Снимок экрана с блюром
      blur_passes = 4
      blur_size = 8
      brightness = 0.65
    }
    general {
      grace = 2
      hide_cursor = true
      ignore_empty_input = true
      fade_in = 1
      fade_out = 1
    }
    input-field {
      size = 320, 50
      outline_thickness = 2
      rounding = 12
      inner_color = rgba(49,50,68,0.85)
      outer_color = rgba(137,180,250,0.6)
      font_family = JetBrainsMono Nerd Font
      font_size = 15
      placeholder_text = <i>Введите пароль...</i>
      fail_text = <b>Неверный пароль</b>
      position = 0, -80
      capslock_color = rgba(249,226,175,0.60)
    }
    label {
      text = cmd[update:1000] echo "$(date +"%H:%M")"
      font_size = 68
      font_family = JetBrainsMono Nerd Font
      color = rgba(205,214,244,1.0)
      position = 0,-160
    }
    label {
      text = cmd[update:5000] echo "$(date +"%A, %d %B %Y")"
      font_size = 17
      font_family = JetBrainsMono Nerd Font
      color = rgba(166,173,200,1.0)
      position = 0,-110
    }
    label {
      text = Caps: $CAPS
      font_size = 13
      color = rgba(249,226,175,0.85)
      position = 0, 10
    }
  '';
}

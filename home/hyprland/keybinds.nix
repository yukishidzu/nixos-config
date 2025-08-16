{ config, pkgs, lib, ... }:

{
  # Горячие клавиши для Hyprland
  wayland.windowManager.hyprland.settings = {
    # Основные горячие клавиши
    bind = [
      # Запуск приложений
      "SUPER, RETURN, exec, kitty"
      "SUPER, D, exec, wofi --show drun"
      "SUPER, Q, killactive"
      "SUPER, M, exit"
      "SUPER, E, exec, nemo"
      "SUPER, F, exec, firefox"
      "SUPER, C, exec, cursor"
      "SUPER, T, exec, telegram-desktop"
      
      # Управление окнами
      "SUPER, V, togglefloating"
      "SUPER, P, pseudo"
      "SUPER, J, togglesplit"
      "SUPER, left, movefocus, l"
      "SUPER, right, movefocus, r"
      "SUPER, up, movefocus, u"
      "SUPER, down, movefocus, d"
      
      # Перемещение окон
      "SUPER SHIFT, left, movewindow, l"
      "SUPER SHIFT, right, movewindow, r"
      "SUPER SHIFT, up, movewindow, u"
      "SUPER SHIFT, down, movewindow, d"
      
      # Изменение размера окон
      "SUPER, R, submap, resize"
      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"
      
      # Рабочие столы
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"
      
      # Перемещение окон на рабочие столы
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"
      
      # Скриншоты и запись
      "PRINT, exec, screenshot.sh full"
      "SUPER SHIFT, S, exec, screenshot.sh area"
      "SUPER SHIFT, W, exec, screenshot.sh window"
      "SUPER SHIFT, R, exec, screenshot.sh record"
      
      # Медиа управление
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioMute, exec, pamixer -t"
      ", XF86AudioLowerVolume, exec, pamixer -d 5"
      ", XF86AudioRaiseVolume, exec, pamixer -i 5"
      
      # Яркость экрана
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      
      # Специальные функции
      "SUPER, B, exec, eww toggle bar"
      "SUPER, W, exec, wallpaper.sh random"
      "SUPER, L, exec, hyprlock"
    ];
    
    # Подкарта для изменения размера
    submap = "resize";
    bind = [
      ", left, resizeactive, -20 0"
      ", right, resizeactive, 20 0"
      ", up, resizeactive, 0 -20"
      ", down, resizeactive, 0 20"
      ", escape, submap, reset"
    ];
    submap = "reset";
    
    # Мышь
    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
    
    # Авозапуск
    exec-once = [
      "waybar"
      "mako"
      "swww init"
      "wallpaper.sh init"
      "eww open bar"
      "cliphist watch"
      "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland"
      "systemctl --user start xdg-desktop-portal-hyprland"
    ];
  };
}

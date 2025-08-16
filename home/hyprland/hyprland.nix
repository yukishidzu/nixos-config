{ config, pkgs, lib, ... }:

{
  # Отключаем catppuccin для hyprland (может не поддерживаться в nixpkgs версии)
  # catppuccin.hyprland.enable = true;
  
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      # Конфигурация мониторов
      monitor = [ ",preferred,auto,1" ];

      # Переменные окружения
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_QPA_PLATFORM,wayland"
        "GDK_BACKEND,wayland,x11"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
      ];

      # Переменные программ
      "$terminal" = "kitty";
      "$menu" = "wofi --show drun";
      "$browser" = "firefox";

      # Автозапуск
      exec-once = [
        "mako"
        "swww init"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        "polkit-gnome-authentication-agent-1"
        "waybar"
      ];

      # Основные настройки
      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 2;
        "col.active_border" = "rgba(89b4faee) rgba(cba6f7ee) 45deg";
        "col.inactive_border" = "rgba(6c7086aa)";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Декорация
      decoration = {
        rounding = 8;
        active_opacity = 0.98;
        inactive_opacity = 0.92;
        
        drop_shadow = true;
        shadow_range = 8;
        shadow_render_power = 3;
        "col.shadow" = "rgba(11111baa)";
        shadow_offset = "0 2";
        
        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
          new_optimizations = true;
          xray = true;
        };
      };

      # Анимации
      animations = {
        enabled = true;
        
        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.12,1"
        ];
        
        animation = [
          "global, 1, 10, easeOutQuint"
          "windows, 1, 4, easeOutQuint, popin 60%"
          "windowsOut, 1, 4, easeInOutCubic, popin 60%"
          "border, 1, 10, easeOutQuint"
          "borderangle, 1, 8, easeOutQuint"
          "fade, 1, 3, easeOutQuint"
          "workspaces, 1, 4, easeOutQuint, slidevert"
        ];
      };

      # Ввод
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";
        
        follow_mouse = 1;
        mouse_refocus = false;
        
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          tap-to-click = true;
          drag_lock = true;
        };
        
        sensitivity = 0;
        accel_profile = "flat";
      };

      # Жесты
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 3;
        workspace_swipe_distance = 200;
        workspace_swipe_invert = true;
        workspace_swipe_min_speed_to_force = 30;
        workspace_swipe_cancel_ratio = 0.5;
        workspace_swipe_create_new = true;
        workspace_swipe_forever = true;
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = false;
        smart_resizing = true;
      };

      # Разное
      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        mouse_move_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^(kitty)$";
        focus_on_activate = false;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        disable_autoreload = false;
        new_window_takes_over_fullscreen = 0;
      };

      # Горячие клавиши
      bind = [
        # Приложения
        "SUPER, Return, exec, $terminal"
        "SUPER, Q, killactive"
        "SUPER, M, exit"
        "SUPER, V, togglefloating"
        "SUPER, D, exec, $menu"
        "SUPER, F, fullscreen"
        "SUPER, B, exec, $browser"
        "SUPER, P, pseudo"
        "SUPER, J, togglesplit"
        "SUPER, T, pin"

        # Перемещение фокуса
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        "SUPER, h, movefocus, l"
        "SUPER, l, movefocus, r"
        "SUPER, k, movefocus, u"
        "SUPER, j, movefocus, d"

        # Перемещение окон
        "SUPER SHIFT, left, movewindow, l"
        "SUPER SHIFT, right, movewindow, r"
        "SUPER SHIFT, up, movewindow, u"
        "SUPER SHIFT, down, movewindow, d"
        "SUPER SHIFT, h, movewindow, l"
        "SUPER SHIFT, l, movewindow, r"
        "SUPER SHIFT, k, movewindow, u"
        "SUPER SHIFT, j, movewindow, d"

        # Воркспейсы
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

        # Перемещение на воркспейс
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

        # Скриншоты
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SUPER, Print, exec, grim - | wl-copy"
        "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +'%Y%m%d_%H%M%S').png"

        # Буфер обмена
        "SUPER, C, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

        # Специальный воркспейс
        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"
      ];

      # Мультимедиа клавиши
      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
      ];

      # Управление мышью
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      # Правила для окон
      windowrule = [
        "float, ^(pavucontrol)$"
        "float, ^(blueman-manager)$"
        "float, ^(nm-connection-editor)$"
        "float, ^(firefox)$ title:^(Picture-in-Picture)$"
        "pin, ^(firefox)$ title:^(Picture-in-Picture)$"
        "size 640 480, ^(firefox)$ title:^(Picture-in-Picture)$"
        "float, ^(org.kde.polkit-kde-authentication-agent-1)$"
        "float, ^(zenity)$"
        "center, ^(zenity)$"
      ];

      # Правила для слоев
      layerrule = [
        "blur, waybar"
        "blur, rofi"
        "blur, notifications"
        "ignorezero, waybar"
        "ignorezero, rofi"
        "ignorezero, notifications"
      ];
    };
  };
}

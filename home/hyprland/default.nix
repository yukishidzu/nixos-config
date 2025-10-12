{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [ ",preferred,auto,1" ];
      env = [
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_QPA_PLATFORM,wayland"
        "GDK_BACKEND,wayland,x11"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
      ];
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(137,180,250,0.8)";
        "col.inactive_border" = "rgba(69,71,90,0.8)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      decoration = {
        rounding = 10;
        blur = { enabled = true; size = 3; passes = 1; vibrancy = 0.1696; };
        drop_shadow = true; shadow_range = 4; shadow_render_power = 3; "col.shadow" = "rgba(26,27,38,0.8)";
      };
      
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      
      dwindle = { pseudotile = true; preserve_split = true; };
      gestures.workspace_swipe = false;
      misc = { force_default_wallpaper = 0; disable_hyprland_logo = false; };
      
      input = {
        kb_layout = "us,ru"; kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        touchpad = { natural_scroll = true; };
        sensitivity = 0;
      };
      
      bind = [
        "SUPER, Q, killactive,"
        "SUPER, M, exit,"
        "SUPER, E, exec, nautilus"
        "SUPER, V, togglefloating,"
        "SUPER, D, exec, wofi --show drun"
        "SUPER, R, exec, wofi --show drun"
        "SUPER, P, pseudo,"
        "SUPER, J, togglesplit,"
        "SUPER, Return, exec, kitty"
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
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
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"
        "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "SUPER, C, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        "XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        "XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        "XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        "XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        "XF86AudioPlay, exec, playerctl play-pause"
        "XF86AudioNext, exec, playerctl next"
        "XF86AudioPrev, exec, playerctl previous"
      ];
      
      bindm = [ "SUPER, mouse:272, movewindow" "SUPER, mouse:273, resizewindow" ];
      
      exec-once = [ 
        "swww init" 
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };
  
  home.packages = with pkgs; [ 
    grim slurp wl-clipboard swww wofi nautilus kitty
    swappy cliphist brightnessctl playerctl
    btop fastfetch eza bat fd ripgrep lazygit
  ];
}
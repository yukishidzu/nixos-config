{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Monitor configuration
      monitor = ",preferred,auto,1";
      
      # Input configuration
      input = {
        kb_layout = "us,ru";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = "no";
        };
        sensitivity = 0;
      };
      
      # General settings
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(89b4faee) rgba(89b4faee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        allow_tearing = false;
      };
      
      # Decoration
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";
      };
      
      # Animations
      animations = {
        enabled = "yes";
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
      
      # Dwindle layout
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      
      # Master layout
      master = {
        new_is_master = true;
      };
      
      # Gestures
      gestures = {
        workspace_swipe = "off";
      };
      
      # Key bindings
      bind = [
        # System
        "SUPER, Q, killactive,"
        "SUPER, M, exit,"
        "SUPER, V, togglefloating,"
        "SUPER, P, pseudo,"
        "SUPER, J, togglesplit,"
        
        # Applications
        "SUPER, Return, exec, kitty"
        "SUPER, D, exec, wofi --show drun"
        "SUPER, R, exec, wofi --show drun"
        "SUPER, E, exec, nautilus"
        
        # Navigation
        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"
        
        # Workspaces
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
        
        # Screenshots
        ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"
        "SUPER SHIFT, S, exec, grim -g \"$(slurp)\" - | swappy -f -"
        
        # Clipboard
        "SUPER, C, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        
        # Media keys
        "XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
        "XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        "XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        "XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        "XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        "XF86AudioPlay, exec, playerctl play-pause"
        "XF86AudioNext, exec, playerctl next"
        "XF86AudioPrev, exec, playerctl previous"
        
        # Power menu and lock
        "SUPER, ESC, exec, wlogout -p layer-shell"
        "SUPER, L, exec, hyprlock"
      ];
      
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
      
      exec-once = [
        "swww init"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };
  
  # Hypridle: auto-lock
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "hyprlock";
        after_sleep_cmd = "";
      };
      listener = [
        {
          timeout = 900; # 15 min lock
          on-timeout = "hyprlock";
        }
      ];
    };
  };
  
  # Link hyprlock config
  xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;

  home.packages = with pkgs; [ 
    grim slurp wl-clipboard swww wofi nautilus kitty
    swappy cliphist brightnessctl playerctl
    wlogout hyprlock hypridle
  ];
}

{ config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "swww init"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];

      # Force a known-good keybind set to neutralize overrides from other modules
      bind = lib.mkForce [
        # Launchers
        "SUPER, Return, exec, kitty"
        "SUPER, D, exec, wofi --show drun"
        
        # Power menu
        "SUPER, ESC, exec, wlogout -p layer-shell"
        
        # Window control
        "SUPER, Q, killactive,"
        "SUPER, V, togglefloating,"
        "SUPER, P, pseudo,"
        "SUPER, J, togglesplit,"
        
        # Focus movement
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
        
        # Move window to workspace
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
      ];

      bindm = lib.mkForce [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];
    };
  };

  # Keep hypridle disabled and remove any hyprlock config remnants
  services.hypridle.enable = false;
  xdg.configFile."hypr/hyprlock.conf".text = "";
}

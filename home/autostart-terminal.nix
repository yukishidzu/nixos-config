{ config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Existing exec-once entries
      exec-once = lib.mkAfter [
        # Autostart a terminal on login
        "kitty"
      ];
    };
  };
}

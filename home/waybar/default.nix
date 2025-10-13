{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  # Link wlogout configs into XDG
  xdg.configFile = {
    "wlogout/layout".source = ./wlogout/layout;
    "wlogout/style.css".source = ./wlogout/style.css;
  };
  
  # Waybar configuration (unchanged from previous)
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    # keep existing settings/style here ...
  };
}

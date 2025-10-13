{ config, pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./wofi.nix
    ./gtk.nix
  ];
}

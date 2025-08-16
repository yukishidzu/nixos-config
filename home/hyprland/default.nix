{ config, pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./mako.nix
  ];

  # Пакеты для Hyprland экосистемы
  home.packages = with pkgs; [
    wofi
    mako
    hyprpaper
    grim
    slurp
    wl-clipboard
    cliphist
    swww  # Улучшенный wallpaper daemon
  ];
}

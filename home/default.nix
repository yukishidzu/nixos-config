{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ./programs-new.nix
  ];

  # Основные настройки пользователя
  home.username = "yukishidzu";
  home.homeDirectory = "/home/yukishidzu";
  home.stateVersion = "25.05";
  home.enableNixpkgsReleaseCheck = false;
  
  # Включить Home Manager
  programs.home-manager.enable = true;
  
  # Разрешить unfree пакеты
  nixpkgs.config.allowUnfree = true;
}

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./home/shell
    ./home/hyprland
    ./home/programs
  ];

  home = {
    username = "yukishidzu";
    homeDirectory = "/home/yukishidzu";
    stateVersion = "25.05";  # Исправлено на 25.05
  };

  # Глобальная тема Catppuccin с исключениями
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # Разрешить Home Manager управлять собой
  programs.home-manager.enable = true;
}

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    inputs.nix-colors.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModule
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

  # Nix Colors для дополнительных тем
  nix-colors = {
    enable = true;
    scheme = "catppuccin-mocha";
  };

  # Разрешить Home Manager управлять собой
  programs.home-manager.enable = true;
}

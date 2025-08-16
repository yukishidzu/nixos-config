{ config, pkgs, lib, ... }:

{
  imports = [
    ./fish.nix
    ./starship.nix
  ];

  # Терминальные утилиты
  home.packages = with pkgs; [
    htop
    btop
    fastfetch
    ripgrep
    fzf
    fd
    bat
    unzip
    p7zip
    tree
  ];
}

{ config, pkgs, lib, ... }:

{
  imports = [
    ./kitty.nix
  ];

  # GUI приложения
  home.packages = with pkgs; [
    firefox
    vscodium
    pavucontrol
    blueman
    networkmanagerapplet
    amnezia-vpn
  ];
}

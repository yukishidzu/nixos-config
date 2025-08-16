{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./fonts.nix
    ./greetd.nix
    ./hardware.nix
  ];
}

{ config, pkgs, lib, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
  ];
}

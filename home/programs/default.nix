{ config, pkgs, lib, ... }:

{
  imports = [
    ./firefox.nix
    ./kitty.nix
    ./vscode.nix
  ];
}

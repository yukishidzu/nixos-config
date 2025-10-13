{ config, pkgs, ... }:
{
  users.users.yukishidzu = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "bluetooth" "input" ];
  };
}

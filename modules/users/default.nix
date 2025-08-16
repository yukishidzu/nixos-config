{ config, pkgs, lib, ... }:

{
  # Пользователь yukishidzu
  users.users.yukishidzu = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "bluetooth" ];
  };

  # Включаем Fish shell системно
  programs.fish.enable = true;
}

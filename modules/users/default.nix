{ config, pkgs, lib, ... }:

{
  # Пользователь yukishidzu
  users.users.yukishidzu = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "audio" 
      "video" 
      "bluetooth" 
      "docker"
      "libvirtd"
      "kvm"
      "input"
      "uucp"
      "dialout"
      "scanner"
      "lp"
    ];
    createHome = true;
    home = "/home/yukishidzu";
  };

  # Включаем Fish shell системно
  programs.fish.enable = true;
  
  # Дополнительные настройки для пользователей
  users.defaultUserShell = pkgs.fish;
  
  # Настройки для sudo (безопасные)
  security.sudo = {
    wheelNeedsPassword = true;
    execWheelOnly = true;
  };
}

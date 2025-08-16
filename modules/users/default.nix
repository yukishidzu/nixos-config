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
      "cdrom"
      "tape"
      "adm"
      "disk"
      "kmem"
      "sys"
      "tty"
    ];
    createHome = true;
    home = "/home/yukishidzu";
  };

  # Включаем Fish shell системно
  programs.fish.enable = true;
  
  # Дополнительные настройки для пользователей
  users.defaultUserShell = pkgs.fish;
  
  # Настройки для sudo
  security.sudo.extraRules = [
    {
      users = [ "yukishidzu" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
}

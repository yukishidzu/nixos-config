{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system
    ./modules/desktop
    ./modules/users
  ];

  # Catppuccin theme для системы
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };

  # Настройки Nix и Flakes (ВАЖНО!)
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org/"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://cursor.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cursor.cachix.org-1:Un9sxK6iB2Lb9o6Qyd74y0hHnRACJZj17K3BQMnif9A="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Загрузчик
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "ntfs" "vfat" "ext4" "btrfs" ];
    kernelParams = [ "quiet" "splash" "nvidia-drm.modeset=1" ];
    kernel.sysctl = {
      "vm.swappiness" = 10;
      "net.core.rmem_max" = 134217728;
      "net.core.wmem_max" = 134217728;
    };
  };

  # Сеть
  networking = {
    hostName = "yukishidzu";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 8080 ];
      allowedUDPPorts = [ 53 67 68 ];
    };
  };

  # Системные настройки
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Безопасность
  security = {
    auditd.enable = true;
    audit.enable = true;
    doas.enable = false;
    sudo.wheelNeedsPassword = true;
    polkit.enable = true;
  };

  # Сервисы
  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        PubkeyAuthentication = true;
      };
    };
    fwupd.enable = true;
    thermald.enable = true;
    power-profiles-daemon.enable = true;
    blueman.enable = true;
    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  # Версия системы (НЕ изменять при обновлениях!)
  system.stateVersion = "25.05";
}

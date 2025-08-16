{ config, pkgs, lib, ... }:

{
  imports = [
    ./locale.nix
    ./audio.nix
    ./power.nix
    ./security.nix
    ./python.nix
  ];

  # Zram swap для экономии памяти
  zramSwap.enable = true;

  # Базовые системные пакеты
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    pciutils
    usbutils
    brightnessctl
    polkit_gnome
    qt5.qtwayland
    qt6.qtwayland
  ];

  # Отключаем ожидание NetworkManager при загрузке
  systemd.services.NetworkManager-wait-online.enable = false;
}

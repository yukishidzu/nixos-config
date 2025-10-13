{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

let
  hasCursor = pkgs-unstable ? cursor;
  hasSpotify = pkgs ? spotify;
  hasVSCodium = pkgs-unstable ? vscodium;
  opt = lib.optionals;
in
{
  # Импорт модулей
  imports = [
    ../hyprland-new.nix
    ../wlogout-new.nix
    ./waybar.nix
    ./wofi.nix
    ./fish.nix
    ./cursor.nix
    ./autostart-terminal.nix
  ];

  # Базовые пакеты
  home.packages =
    (with pkgs; [
      firefox
      telegram-desktop
      vlc
      file-roller
      pavucontrol
      nodejs
      python3
      rustc
      cargo
      go
    ])
    ++ (opt hasSpotify [ pkgs.spotify ])
    ++ (opt hasCursor [ pkgs-unstable.cursor ])
    ++ (opt hasVSCodium [ pkgs-unstable.vscodium ]);

  # XDG и mime
  xdg = {
    enable = true;
    mimeApps.enable = true;
  };

  # Не управляем Firefox через HM
  programs.firefox.enable = false;
}

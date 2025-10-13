{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

let
  hasCursor = pkgs-unstable ? cursor;
  hasSpotify = pkgs ? spotify;
  hasVSCodium = pkgs-unstable ? vscodium;
  opt = lib.optionals;
in
{
  # Импорт модулей программ
  imports = [
    ./hyprland-new.nix
    ./wlogout-new.nix
  ];

  # Основные программы
  home.packages = (with pkgs; [
    telegram-desktop
    vlc
    file-roller
    pavucontrol
    nodejs
    python3
    rustc
    cargo
    go
  ]) ++ (opt hasSpotify [ pkgs.spotify ])
     ++ (opt hasCursor [ pkgs-unstable.cursor ])
     ++ (opt hasVSCodium [ pkgs-unstable.vscodium ]);

  # Git
  programs.git = {
    enable = true;
    userName = "Yukishidzu";
    userEmail = "CHANGE_ME@EXAMPLE";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
  
  # Kitty терминал с Catppuccin
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 11;
      background_opacity = "0.9";
      foreground = "#CDD6F4";
      background = "#1E1E2E";
      selection_foreground = "#1E1E2E";
      selection_background = "#F5E0DC";
      color0 = "#45475A"; color1 = "#F38BA8"; color2 = "#A6E3A1"; color3 = "#F9E2AF";
      color4 = "#89B4FA"; color5 = "#F5C2E7"; color6 = "#94E2D5"; color7 = "#BAC2DE";
      color8 = "#585B70"; color9 = "#F38BA8"; color10 = "#A6E3A1"; color11 = "#F9E2AF";
      color12 = "#89B4FA"; color13 = "#F5C2E7"; color14 = "#94E2D5"; color15 = "#A6ADC8";
    };
  };

  # Программы командной строки
  programs.bat.enable = true;
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          lightTheme = false;
          activeBorderColor = [ "#89b4fa" "bold" ];
          inactiveBorderColor = [ "#a6adc8" ];
          optionsTextColor = [ "#89b4fa" ];
          selectedLineBgColor = [ "#313244" ];
          selectedRangeBgColor = [ "#313244" ];
          cherryPickedCommitBgColor = [ "#45475a" ];
          cherryPickedCommitFgColor = [ "#89b4fa" ];
        };
      };
    };
  };
  
  programs.eza = {
    enable = true;
    enableBashIntegration = false;
    enableZshIntegration = false;
    enableFishIntegration = false;
  };

  # Waybar
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  # Не управлять Firefox
  programs.firefox.enable = false;
  
  # XDG настройки
  xdg = {
    enable = true;
    mimeApps.enable = true;
  };

  # Централизованные темы Catppuccin
  catppuccin = {
    flavor = "mocha";
    accent = "blue";
  };
  
  # GTK тема
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "blue" ];
        size = "standard";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override { flavor = "mocha"; accent = "blue"; };
    };
    cursorTheme = {
      name = "Catppuccin-Mocha-Blue-Cursors";
      package = pkgs.catppuccin-cursors.mochaBlue;
      size = 24;
    };
  };
  
  # Qt тема
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
}

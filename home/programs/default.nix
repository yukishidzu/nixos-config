{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  # Основные программы
  home.packages = with pkgs; [
    firefox
  ] ++ (with pkgs-unstable; [
    cursor
    vscodium
  ]) ++ (with pkgs; [
    telegram-desktop
    discord
    vlc
    spotify
    file-roller
    pavucontrol
    nodejs
    python3
    rustc
    cargo
    go
  ]);
  
  # Git конфигурация
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
  
  # Kitty терминал
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
  
  # Firefox настройки — без extensions.settings, чтобы не триггерить assertion HM
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;
      # Если в системе где‑то подключались extensions.settings через overlays или др. модули,
      # жёстко подтверждаем перезапись, чтобы снять assertion:
      extensions.force = true;
      settings = {
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "browser.uidensity" = 1;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };
  
  # Qt настройки — catppuccin требует kvantum
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };
  
  # GTK тема и иконки
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
  
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "x-scheme-handler/about" = "firefox.desktop";
        "x-scheme-handler/unknown" = "firefox.desktop";
      };
    };
  };
}

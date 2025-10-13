{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./shell
    ./programs
    ./desktop
  ];

  # Basic user settings
  home = {
    username = "yukishidzu";
    homeDirectory = "/home/yukishidzu";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;
  };

  # User packages (not duplicated from system)
  home.packages = with pkgs; [
    # User-specific applications
    firefox
    telegram-desktop
    vlc
    file-roller
    
    # Development tools (user-level)
    nodejs
    python3
    rustc
    cargo
    go
  ] ++ lib.optionals (pkgs ? spotify) [ pkgs.spotify ]
    ++ lib.optionals (pkgs-unstable ? cursor) [ pkgs-unstable.cursor ]
    ++ lib.optionals (pkgs-unstable ? vscodium) [ pkgs-unstable.vscodium ];

  # XDG configuration
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "firefox.desktop";
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "application/pdf" = "firefox.desktop";
        "image/jpeg" = "org.gnome.eog.desktop";
        "image/png" = "org.gnome.eog.desktop";
      };
    };
  };

  # Catppuccin theme configuration
  catppuccin = {
    flavor = "mocha";
    accent = "blue";
  };

  # Enable home-manager
  programs.home-manager.enable = true;
}

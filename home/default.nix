{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./desktop
    ./programs
    ./shell
  ];

  # Basic user settings
  home = {
    username = "yukishidzu";
    homeDirectory = "/home/yukishidzu";
    stateVersion = "25.05";
    enableNixpkgsReleaseCheck = false;
  };

  # Catppuccin theme configuration
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # XDG configuration
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = "$HOME/Desktop";
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      templates = "$HOME/Templates";
      publicShare = "$HOME/Public";
    };
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

  # Environment variables
  home.sessionVariables = {
    EDITOR = "cursor";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
  };

  # User packages
  home.packages = with pkgs; [
    # Basic utilities
    btop
    fastfetch
    eza
    bat
    ripgrep
    fd
    fzf
    tree
    jq
    unzip
    zip
    p7zip
    wget
    curl
    rsync
    
    # Media
    vlc
    pavucontrol
    
    # Communication
    telegram-desktop
    
    # Development (user-level)
    nodejs
    python3
    rustc
    cargo
    go
  ] ++ lib.optionals (pkgs ? spotify) [ pkgs.spotify ]
    ++ lib.optionals (pkgs-unstable ? cursor) [ pkgs-unstable.cursor ]
    ++ lib.optionals (pkgs-unstable ? vscodium) [ pkgs-unstable.vscodium ];
}

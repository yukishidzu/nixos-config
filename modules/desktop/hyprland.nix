{ config, lib, pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Enable hyprlock at system level
  programs.hyprlock.enable = true;

  # Additional Wayland programs
  programs.waybar.enable = true;

  # Greetd display manager with tuigreet
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      user = "greeter";
    };
  };

  # XDG Desktop Portal
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ 
      xdg-desktop-portal-hyprland 
      xdg-desktop-portal-gtk 
    ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  # Wayland environment variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  # System packages needed for Hyprland
  environment.systemPackages = with pkgs; [
    # Core Wayland utilities
    hyprlock
    hypridle
    wlogout
    
    # Qt/Wayland support
    qt5.qtwayland
    qt6.qtwayland
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    
    # Polkit and XDG utilities
    polkit_gnome
    xdg-utils
    xdg-user-dirs
  ];

  # Enable libinput for input devices
  services.libinput.enable = true;

  # X server configuration (for XWayland)
  services.xserver = {
    enable = true;
    videoDrivers = lib.mkDefault [ "amdgpu" "intel" "nouveau" "modesetting" ];
  };
}

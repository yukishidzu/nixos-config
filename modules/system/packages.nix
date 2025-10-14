{ config, lib, pkgs, ... }:

{
  # System packages for comfortable work
  environment.systemPackages = with pkgs; [
    # System utilities
    btop
    htop
    fastfetch
    tree
    ripgrep
    fd
    fzf
    jq
    unzip
    zip
    p7zip
    file-roller
    
    # Network tools
    wget
    curl
    rsync
    nmap
    nettools
    dnsutils
    
    # Hardware info
    pciutils
    usbutils
    lshw
    lm_sensors
    acpi
    
    # Media
    ffmpeg-full
    gstreamer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    
    # Archive tools
    unzip
    zip
    p7zip
    file-roller
    
    # System monitoring
    htop
    iotop
    btop
    
    # Development libraries
    openssl
    zlib
    pkg-config
    cmake
    gnumake
    gcc
    clang
    
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
}

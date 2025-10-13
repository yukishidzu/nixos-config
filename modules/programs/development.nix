{ config, lib, pkgs, ... }:

{
  # Development tools available system-wide
  environment.systemPackages = with pkgs; [
    # Version control
    git
    git-lfs
    
    # Build tools
    gcc
    clang
    cmake
    pkg-config
    
    # Archive tools
    wget
    curl
    rsync
    unzip
    p7zip
    
    # System utilities
    pciutils
    usbutils
    lshw
    lm_sensors
    acpi
    
    # Network tools
    nmap
    nettools
    dnsutils
    
    # Performance monitoring
    htop
    iotop
    
    # Development libraries
    openssl
    zlib
  ];
  
  # Enable Docker for development
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
  
  # Enable Podman as Docker alternative
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };
}

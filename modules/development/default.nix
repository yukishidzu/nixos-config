{ config, lib, pkgs, ... }:

{
  # Базовые инструменты разработки
  environment.systemPackages = with pkgs; [
    # Version control
    git
    git-lfs
    gh
    
    # Build tools
    gcc
    clang
    cmake
    pkg-config
    gnumake
    
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
  
  # Docker для контейнеризации
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
  
  # Добавляем пользователя в группу docker
  users.users.yukishidzu.extraGroups = [ "docker" ];
}

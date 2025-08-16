{ config, pkgs, lib, ... }:

{
  imports = [
    ./locale.nix
    ./audio.nix
    ./power.nix
    ./security.nix
    ./python.nix
    ./gaming.nix
    ./development.nix
    ./monitoring.nix
  ];

  # Zram swap для экономии памяти
  zramSwap.enable = true;

  # Базовые системные пакеты
  environment.systemPackages = with pkgs; [
    # Основные утилиты
    git
    wget
    curl
    pciutils
    usbutils
    brightnessctl
    polkit_gnome
    qt5.qtwayland
    qt6.qtwayland
    
    # Дополнительные системные утилиты
    htop
    btop
    neofetch
    fastfetch
    lsd
    bat
    fd
    ripgrep
    fzf
    zoxide
    exa
    procs
    du-dust
    bottom
    
    # Сетевые утилиты
    nmap
    wireshark
    tcpdump
    netcat
    mtr
    
    # Мониторинг системы
    iotop
    iostat
    sysstat
    lm_sensors
    psensor
    
    # Разработка
    nodejs_20
    python3
    rustc
    cargo
    gcc
    gnumake
    cmake
    
    # Дополнительные утилиты
    gparted
    gsmartcontrol
    hwinfo
    inxi
    lshw
    playerctl
    pamixer
    xdg-utils
    xdg-user-dirs
  ];

  # Отключаем ожидание NetworkManager при загрузке
  systemd.services.NetworkManager-wait-online.enable = false;
  
  # Оптимизация системы
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
    DefaultTimeoutStartSec=10s
  '';
  
  # Настройки для игр
  programs.gamemode.enable = true;
  programs.steam.enable = true;
  
  # Дополнительные настройки
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
    fuse3
    icu
    libunwind
    libuuid
    openssl
    libGL
    libGLU
    xorg.libX11
    xorg.libXcursor
    xorg.libXrandr
    xorg.libXext
    xorg.libXrender
    xorg.libXfixes
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXinerama
    xorg.libXxf86vm
    xorg.libXScrnSaver
    xorg.libXv
    xorg.libXvMC
    xorg.libXpm
    xorg.libXft
    xorg.libXmu
    xorg.libXaw
    xorg.libXss
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXinerama
    xorg.libXxf86vm
    xorg.libXScrnSaver
    xorg.libXv
    xorg.libXvMC
    xorg.libXpm
    xorg.libXft
    xorg.libXmu
    xorg.libXaw
    xorg.libXss
  ];
}

{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./kitty.nix
  ];

  # GUI приложения
  home.packages = with pkgs; [
    # Основные браузеры
    firefox
    chromium
    
    # Редакторы кода
    vscodium
    cursor # Основной редактор Cursor
    
    # Мессенджеры
    telegram-desktop
    signal-desktop
    discord
    
    # Медиа
    mpv
    vlc
    spotify
    
    # Утилиты для работы
    pavucontrol
    blueman
    networkmanagerapplet
    amnezia-vpn
    
    # Красивые утилиты
    eww-wayland # Виджеты для Wayland
    swww # Анимированные обои
    grim # Скриншоты
    slurp # Выбор области для скриншота
    wf-recorder # Запись экрана
    wl-clipboard # Буфер обмена
    cliphist # История буфера обмена
    
    # Системные утилиты
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
    
    # Разработка
    nodejs_20
    python3
    rustc
    cargo
    
    # Файловые менеджеры
    nemo
    dolphin
    
    # Дополнительные утилиты
    gparted
    gsmartcontrol
    hwinfo
    inxi
    lshw
    pciutils
    usbutils
    brightnessctl
    playerctl
    pamixer
    
    # Красивые темы и иконки
    papirus-icon-theme
    nordic
    whitesur-gtk-theme
    whitesur-icon-theme
  ];

  # Spicetify для Spotify
  programs.spicetify = {
    enable = true;
    theme = inputs.spicetify-nix.packages.${pkgs.system}.default.themes.catppuccin;
    colorScheme = "mocha";
    
    enabledExtensions = with inputs.spicetify-nix.packages.${pkgs.system}.default.extensions; [
      fullAppDisplay
      shuffle
      hidePodcasts
    ];
  };
}

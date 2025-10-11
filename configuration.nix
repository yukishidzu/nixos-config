{ config, pkgs, lib, ... }:

let
  # Импортируем Home Manager
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in
{
  ########################################################
  # Импорт выявленного железа (создан installer‑ом)
  ########################################################
  imports = [ 
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  ########################################################
  # Загрузка и базовая инициализация
  ########################################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName              = "yukishidzu";
    networkmanager.enable = true;q
  };

  ########################################################
  # Локализация, время, TTY‑шрифт
  ########################################################
  i18n = {
    defaultLocale    = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  time.timeZone = "Europe/Moscow";

  console = {
    font         = "Lat2-Terminus16";  # читаемая кириллица в TTY
    useXkbConfig = true;               # TTY берёт те же XKB‑настройки
  };

  ########################################################
  # XKB-раскладка/драйвер (нужен Xwayland в Hyprland)
  ########################################################
  services.xserver = {
    enable       = true;               # только ввод + драйвер
    videoDrivers = [ "amdgpu" ];       # встроенная Radeon (Ryzen 7xxx)
    xkb.layout   = "us,ru";
    xkb.options  = "grp:win_space_toggle";
  };

  ########################################################
  # Bluetooth
  ########################################################
  hardware.bluetooth.enable = true;
  services.blueman.enable   = true;

  ########################################################
  # Аудио — PipeWire (+ эмуляция PulseAudio API)
  ########################################################
  services.pulseaudio.enable = false;
  security.rtkit.enable      = true;

  services.pipewire = {
    enable            = true;
    alsa.enable       = true;
    alsa.support32Bit = true;
    pulse.enable      = true;  # legacy‑клиенты
    jack.enable       = false;
  };

  ########################################################
  # Hyprland + Waybar + greetd/tuigreet
  ########################################################
  programs.hyprland = {
    enable          = true;
    withUWSM        = true;   # systemd‑user integration
    xwayland.enable = true;
  };

  programs.waybar.enable = true;

  services.greetd = {
    enable   = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user    = "greeter";
      };
    };
  };

  ########################################################
  # Пользователь (Fish + Starship)
  ########################################################
  users.users.yukishidzu = {
    isNormalUser = true;
    shell        = pkgs.fish;
    extraGroups  = [ "wheel" "networkmanager" "audio" "video" "bluetooth" ];
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # FZF в подсказках
      set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse"
      # Красивый prompt
      starship init fish | source
    '';
  };

  programs.starship.enable = true;

  ########################################################
  # Шрифты (новая схема nerd‑fonts в 25.05)
  ########################################################
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono      # основной моношрифт
    nerd-fonts.symbols-only        # powerline/dev‑иконки
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
  ########################################################
  # Базовый набор СИСТЕМНЫХ утилит (минимум)
  ########################################################
  environment.systemPackages = with pkgs; [
    ## Базовые системные утилиты
    git          wget          curl          
    pciutils     usbutils      brightnessctl
    
    ## Необходимые для Hyprland
    polkit_gnome  # аутентификация
    qt5.qtwayland # Qt поддержка Wayland
    qt6.qtwayland
  ];

  ########################################################
  # Энергосбережение для ноутбука
  ########################################################
  services.tlp.enable = true;
  powerManagement.cpuFreqGovernor = "schedutil";

  ########################################################
  # Дополнительные настройки для ноутбука
  ########################################################
  # Поддержка тачпада
  services.libinput.enable = true;
  
  # Автоматическое подключение к сети
  systemd.services.NetworkManager-wait-online.enable = false;
  
  # Поддержка NTFS для работы с Windows разделами
  boot.supportedFilesystems = [ "ntfs" ];

  # Включение zram для экономии памяти
  zramSwap.enable = true;

  # Безопасность
  security.sudo.wheelNeedsPassword = true;

  ########################################################
  # Home Manager конфигурация
  ########################################################
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.yukishidzu = import ./home.nix;
  };

  ########################################################
  # Версия состояния системы — НЕ меняй при апгрейде!
  ########################################################
  system.stateVersion = "25.05";
}

{ config, pkgs, lib, inputs, pkgs-unstable, hardware, ... }:

{
  imports = [ 
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "auto";
      };
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };
    initrd = {
      systemd.enable = true;
      verbose = false;
      compressor = "zstd";
    };
  };

  networking = {
    hostName = "yukishidzu";
    networkmanager.enable = true;
    useDHCP = false;
  };

  # Перенесены параметры sysctl в boot.kernel.sysctl
  boot.kernel.sysctl = {
    "net.core.default_qdisc" = "fq_codel";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
    };
  };

  time.timeZone = "Europe/Moscow";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
    earlySetup = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = lib.mkDefault [ "amdgpu" "intel" "nouveau" "modesetting" ];
    xkb = {
      layout = "us,ru";
      options = "grp:win_space_toggle";
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
    wireplumber.enable = true;
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.waybar.enable = true;

  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
      user = "greeter";
    };
  };

  users.users.yukishidzu = {
    isNormalUser = true;
    shell = pkgs.bash;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" "bluetooth" "input" ];
  };

  environment.systemPackages = with pkgs; [
    git wget curl rsync
    pciutils usbutils lshw lm_sensors acpi
    polkit_gnome xdg-utils xdg-user-dirs
    qt5.qtwayland qt6.qtwayland libsForQt5.qt5ct qt6Packages.qt6ct
    ffmpeg-full
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland xdg-desktop-portal-gtk ];
    config.common.default = [ "hyprland" "gtk" ];
  };

  services.libinput.enable = true;

  boot.supportedFilesystems = [ "ntfs" "exfat" ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  security = {
    sudo.wheelNeedsPassword = true;
    polkit.enable = true;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    inter
    roboto
    liberation_ttf
  ];

  system.stateVersion = "25.05";
}

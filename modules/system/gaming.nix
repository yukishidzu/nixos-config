{ config, pkgs, lib, ... }:

{
  # Игровые настройки
  programs = {
    # Gamemode для оптимизации игр
    gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
          ioprio = 0;
        };
        gpu = {
          apply_gpu_optimisations = 1;
          gpu_device = 0;
          amd_performance_level = "high";
        };
        custom = {
          start = "";
          end = "";
        };
      };
    };

    # Steam
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    # Wine и игры
    wine.enable = true;
  };

  # Дополнительные игровые пакеты
  environment.systemPackages = with pkgs; [
    # Игровые платформы
    steam
    steam-run
    lutris
    wine
    winetricks
    
    # Игровые утилиты
    gamemode
    mangohud
    goverlay
    radeontop
    nvtop
    
    # Эмуляторы
    dolphin-emu
    pcsx2
    retroarch
    citra
    yuzu
    
    # Игровые библиотеки
    lib32.gamemode
    lib32.wine
    lib32.steam
  ];

  # Настройки для игр
  hardware = {
    # Настройки для AMD GPU
    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
        rocm-opencl-icd
        rocm-opencl-runtime
      ];
    };
  };

  # Сетевые настройки для игр
  networking.firewall = {
    allowedTCPPorts = [ 22 80 443 8080 27015 27016 27017 27018 27019 27020 ];
    allowedUDPPorts = [ 53 67 68 27015 27016 27017 27018 27019 27020 ];
  };
}

{ config, lib, pkgs, ... }:

{
  # Internationalization settings
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

  # Time zone
  time.timeZone = "Europe/Moscow";

  # Console configuration
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
    earlySetup = true;
  };

  # Keyboard layout for X11/Wayland
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:win_space_toggle";
  };
}

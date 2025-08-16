{ config, lib, ... }:

{
  # Временная зона
  time.timeZone = "Europe/Moscow";
  
  # Локализация
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  # Настройки консоли
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };
}


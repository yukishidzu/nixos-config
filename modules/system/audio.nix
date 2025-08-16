{ config, lib, ... }:

{
  # Отключаем PulseAudio
  services.pulseaudio.enable = false;
  
  # Включаем PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    
    # Дополнительные настройки
    wireplumber.enable = true;
    
    # Настройки для лучшего качества
    config.pipewire = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 32;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 8192;
      };
    };
  };
  
  # Дополнительные аудио сервисы
  services.pipewire.media-session.enable = false;
  
  # Настройки ALSA
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  
  # Настройки для Bluetooth аудио
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}

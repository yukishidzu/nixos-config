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
    jack.enable = false;
  };
}

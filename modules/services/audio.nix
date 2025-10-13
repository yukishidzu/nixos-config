{ config, lib, pkgs, ... }:

{
  # Disable PulseAudio
  services.pulseaudio.enable = false;

  # Enable PipeWire
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;  # Enable JACK for professional audio
    wireplumber.enable = true;
    
    # Low latency configuration
    extraConfig.pipewire = {
      "10-clock-rate" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 2048;
        };
      };
    };
  };

  # Enable RTKit for real-time audio
  security.rtkit.enable = true;

  # Add user to audio group (handled in users.nix)
  # Audio packages will be in home-manager
}

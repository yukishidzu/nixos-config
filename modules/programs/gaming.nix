{ config, lib, pkgs, ... }:

{
  # Gaming support
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  
  # GameMode for performance optimization
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
      };
    };
  };
  
  # Gaming packages
  environment.systemPackages = with pkgs; [
    # Gaming tools
    lutris
    bottles
    heroic
    
    # Wine
    wineWowPackages.waylandFull
    winetricks
    
    # Emulators
    retroarch
    
    # Performance monitoring
    mangohud
    gamescope
  ];
  
  # Enable 32-bit support for games
  hardware.opengl.driSupport32Bit = true;
  hardware.pulseaudio.support32Bit = true;
}

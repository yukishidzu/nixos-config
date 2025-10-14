{ config, lib, pkgs, ... }:

{
  # Multimedia support
  environment.systemPackages = with pkgs; [
    # Media libraries
    ffmpeg-full
    gstreamer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
  ];
  
  # Hardware video acceleration
  hardware.graphics = {
    enable = true;
    # driSupport and driSupport32Bit options were removed in NixOS 25.05
    # They are now enabled automatically when hardware.graphics.enable = true
    
    extraPackages = with pkgs; [
      # Intel
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      
      # AMD
      mesa.drivers
      amdvlk
    ];
    
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
      vaapiIntel
      amdvlk
    ];
  };
  
  # Enable VA-API and VDPAU
  environment.variables = {
    LIBVA_DRIVER_NAME = "iHD";
    VDPAU_DRIVER = "va_gl";
  };
}
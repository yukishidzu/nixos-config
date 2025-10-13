{ config, lib, pkgs, ... }:

{
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };

  # Bluetooth manager
  services.blueman.enable = true;

  # Add bluetooth packages
  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
  ];
}

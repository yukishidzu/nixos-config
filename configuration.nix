{ config, pkgs, lib, inputs, pkgs-unstable, hardware, ... }:

{
  imports = [
    # Hardware configuration
    ./hardware-configuration.nix
    
    # Core system modules
    ./modules/core/boot.nix
    ./modules/core/networking.nix
    ./modules/core/users.nix
    ./modules/core/localization.nix
    
    # Services
    ./modules/services/audio.nix
    ./modules/services/bluetooth.nix
    
    # Desktop environment
    ./modules/desktop/hyprland.nix
    ./modules/desktop/fonts.nix
    
    # System configuration
    ./modules/system/nix.nix
    ./modules/system/systemd.nix
    ./modules/system/security.nix
    ./modules/system/power.nix
    ./modules/system/packages.nix
    
    # Development tools
    ./modules/development/default.nix
    
    # Multimedia support
    ./modules/programs/multimedia.nix
    
  ];

  # System version
  system.stateVersion = "25.05";

  # Home Manager integration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs pkgs-unstable; };
    users.yukishidzu = import ./home;
    backupFileExtension = "backup";
  };
}

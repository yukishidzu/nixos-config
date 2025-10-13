{ config, lib, pkgs, ... }:

{
  # Enable fish shell system-wide
  programs.fish.enable = true;

  # User configuration
  users.users.yukishidzu = {
    isNormalUser = true;
    shell = pkgs.fish;  # Changed from bash to fish for consistency with home-manager
    extraGroups = [ 
      "wheel" 
      "networkmanager" 
      "audio" 
      "video" 
      "bluetooth" 
      "input"
      "docker"  # Added for Docker support
    ];
    description = "Yukishidzu";
  };

  # Security settings
  security = {
    sudo = {
      wheelNeedsPassword = true;
      execWheelOnly = true;  # Only wheel group can use sudo
    };
    polkit.enable = true;
    rtkit.enable = true;
    
    # Enable AppArmor for additional security
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };
    
    # PAM configuration
    pam = {
      loginLimits = [
        { domain = "@wheel"; item = "nofile"; type = "soft"; value = "524288"; }
        { domain = "@wheel"; item = "nofile"; type = "hard"; value = "1048576"; }
      ];
      services = {
        hyprlock = {};
        login.enableGnomeKeyring = true;
      };
    };
  };
}

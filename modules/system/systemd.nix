{ config, lib, pkgs, ... }:

{
  # Systemd configuration and optimizations
  systemd = {
    # Services configuration
    services = {
      # Faster boot times
      "systemd-udev-settle".enable = false;
      "NetworkManager-wait-online".enable = false;
    };
    
    # User services
    user.services = {
      # Polkit authentication agent
      polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = [ "graphical-session.target" ];
        wants = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };
    
    # Systemd tweaks for better performance
    extraConfig = ''
      DefaultTimeoutStopSec=10s
      DefaultTimeoutStartSec=10s
    '';
    
    # Coredump configuration
    coredump = {
      enable = true;
      extraConfig = ''
        Storage=external
        Compress=yes
      '';
    };
  };
  
  # Journal configuration
  services.journald = {
    extraConfig = ''
      SystemMaxUse=500M
      RuntimeMaxUse=100M
      MaxRetentionSec=1week
    '';
  };
}

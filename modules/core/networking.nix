{ config, lib, pkgs, ... }:

{
  networking = {
    # Hostname
    hostName = "yukishidzu";
    
    # Network management
    networkmanager.enable = true;
    useDHCP = false;
    
    # Firewall configuration
    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
      # Common development ports (can be customized)
      allowedTCPPorts = [ ];
      allowedUDPPorts = [ ];
    };
  };

  # Enable fail2ban for additional security
  services.fail2ban = {
    enable = true;
    bantime = "24h";
    bantime-increment = {
      enable = true;
      maxtime = "168h";  # 1 week
    };
  };

  # DNS configuration for better performance and privacy
  services.resolved = {
    enable = true;
    dnssec = "true";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" "8.8.4.4" ];
    dnsovertls = "true";
  };
}

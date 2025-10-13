{ config, lib, pkgs, ... }:

{
  boot = {
    # Bootloader configuration
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        consoleMode = "auto";
      };
      efi.canTouchEfiVariables = true;
      timeout = 2;
    };

    # InitRD configuration
    initrd = {
      systemd.enable = true;
      verbose = false;
      compressor = "zstd";
    };

    # Supported filesystems
    supportedFilesystems = [ "ntfs" "exfat" ];

    # Kernel optimizations
    kernel.sysctl = {
      # Network optimizations
      "net.core.default_qdisc" = "fq_codel";
      "net.ipv4.tcp_congestion_control" = "bbr";
      
      # Memory management optimizations
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 15;
      "vm.dirty_background_ratio" = 5;
    };

    # Performance kernel parameters
    kernelParams = [ 
      "quiet" 
      "splash" 
      "mitigations=off"  # Disable CPU mitigations for better performance (security trade-off)
    ];
  };

  # zRAM configuration with improved settings
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;  # Increased from 25% for better performance
  };
}

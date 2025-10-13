{ config, lib, pkgs, ... }:

{
  # Nix configuration
  nix = {
    settings = {
      # Enable flakes and new nix command
      experimental-features = [ "nix-command" "flakes" ];
      
      # Auto-optimize store
      auto-optimise-store = true;
      
      # Trusted users
      trusted-users = [ "root" "@wheel" ];
      
      # Binary caches
      substituters = [
        "https://cache.nixos.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
      ];
      
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7T5J9HO2A9q/jrANF6F0hFCCTKjN9vE2Dx6q2Lr4Z8="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
      
      # Build settings
      max-jobs = "auto";
      cores = 0;
      
      # Keep build logs
      keep-outputs = true;
      keep-derivations = true;
      
      # Warn about dirty git repos
      warn-dirty = false;
    };
    
    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    
    # Store optimization
    optimise = {
      automatic = true;
      dates = [ "03:45" ];
    };
  };
  
  # Allow unfree packages globally
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };
}

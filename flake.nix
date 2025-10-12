{
  description = "Yukishidzu's Universal NixOS Configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware = { url = "github:NixOS/nixos-hardware"; };
    catppuccin = { url = "github:catppuccin/nix"; inputs.nixpkgs.follows = "nixpkgs"; };
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hardware, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
            "discord"
            "spotify"
          ];
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = { allowUnfree = true; };
      };
      specialArgs = { inherit inputs pkgs-unstable hardware; };
    in
    {
      nixosConfigurations = {
        yukishidzu = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = [
            ./configuration.nix
            ./hardware-configuration.nix
            ({ config, ... }: {
              nixpkgs.config = {
                allowUnfree = true;
                allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
                  "discord"
                  "spotify"
                ];
              };
            })
            home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
            {
              nix.settings = {
                experimental-features = [ "nix-command" "flakes" ];
                auto-optimise-store = true;
                trusted-users = [ "root" "@wheel" ];
                substituters = [
                  "https://cache.nixos.org"
                  "https://hyprland.cachix.org"
                  "https://nix-community.cachix.org"
                ];
                trusted-public-keys = [
                  "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                  "hyprland.cachix.org-1:a7T5J9HO2A9q/jrANF6F0hFCCTKjN9vE2Dx6q2Lr4Z8="
                  "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                ];
              };
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs pkgs-unstable; };
                users.yukishidzu = import ./home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };

      # Dev shell without non-derivation entries
      devShells.${system}.default = pkgs.mkShell {
        name = "nixos-config-dev";
        packages = with pkgs; [
          nixpkgs-fmt
          nil
          git
          just
          nix-tree
          nix-du
        ];
        shellHook = ''
          echo "Dev shell ready: nixpkgs-fmt, nil, git, just, nix-tree, nix-du"
          echo "Run: nix fmt .   |   nix flake check"
        '';
      };

      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}

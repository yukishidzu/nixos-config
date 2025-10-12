{
  description = "Yukishidzu's Universal NixOS Configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware = {
      url = "github:NixOS/nixos-hardware";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hardware, catppuccin, ... }@inputs:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      system = "x86_64-linux";
      pkgsConfig = {
        allowUnfree = true;
        permittedInsecurePackages = [ ];
      };
      pkgs = import nixpkgs {
        inherit system;
        config = pkgsConfig;
        overlays = [
          (final: prev: {
            mesa = prev.mesa.override {
              galliumDrivers = [ "radeonsi" "swrast" "iris" "crocus" ];
              vulkanDrivers = [ "amd" "intel" ];
            };
          })
        ];
      };
      pkgs-unstable = import nixpkgs-unstable { inherit system; config = pkgsConfig; };
      hardwareModules = [
        hardware.nixosModules.common-pc
        hardware.nixosModules.common-pc-ssd
        hardware.nixosModules.common-cpu-amd
        hardware.nixosModules.common-cpu-amd-pstate
        hardware.nixosModules.common-gpu-amd
      ];
      specialArgs = { inherit inputs pkgs-unstable hardware; };
    in
    {
      nixosConfigurations = {
        yukishidzu = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          modules = hardwareModules ++ [
            ./configuration.nix
            ./hardware-configuration.nix
            home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
            {
              nix = {
                settings = {
                  experimental-features = [ "nix-command" "flakes" ];
                  auto-optimise-store = true;
                  trusted-users = [ "root" "@wheel" ];
                  substituters = [
                    "https://cache.nixos.org"
                    "https://hyprland.cachix.org"
                    "https://nix-community.cachix.org"
                    "https://cuda-maintainers.cachix.org"
                  ];
                  trusted-public-keys = [
                    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                    "hyprland.cachix.org-1:a7T5J9HO2A9q/jrANF6F0hFCCTKjN9vE2Dx6q2Lr4Z8="
                    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                    "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrwrelGdILs9kl3mJbrOWdU="
                  ];
                  max-jobs = "auto";
                  cores = 0;
                };
                gc = { automatic = true; dates = "daily"; options = "--delete-older-than 3d"; };
                optimise = { automatic = true; dates = [ "weekly" ]; };
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
      devShells.${system}.default = pkgs.mkShell {
        name = "nixos-config-dev";
        packages = with pkgs; [ nixpkgs-fmt nil git home-manager nix-tree nix-du ];
        shellHook = ''
          echo "🚀 Оптимизированная среда разработки NixOS"
          echo "📝 nix fmt .                                    - форматировать код"
          echo "🔨 nix flake check                              - проверить конфигурацию"
          echo "🔄 sudo nixos-rebuild switch --flake .#yukishidzu - применить систему"
          echo "🏠 home-manager switch --flake .#yukishidzu       - применить пользователя"
        '';
      };
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}

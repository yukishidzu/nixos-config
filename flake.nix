{
  description = "Yukishidzu's Universal NixOS Configuration";
  
  inputs = {
    # Основные каналы — закрепляем стабильные версии для быстрой оценки
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # Unstable для свежих пакетов (редакторы, браузеры)
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager с закрепленным коммитом для стабильности
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Аппаратная совместимость для универсальной поддержки железа
    hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Темы и внешний вид
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";  # Оптимизация зависимостей
    };
    
    # На будущее — опциональные модули (закомментированы для оптимизации)
    # nix-colors.url = "github:misterio77/nix-colors";
    # spicetify-nix.url = "github:the-argus/spicetify-nix";
    
    # Hyprland — используем nixpkgs версию для стабильности
    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hardware, catppuccin, ... }@inputs:
    let
      # Поддерживаемые системы
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      system = "x86_64-linux";  # Основная система
      
      # Оптимизированная конфигурация pkgs
      pkgsConfig = {
        allowUnfree = true;
        # Меньше разрешённых небезопасных пакетов для безопасности
        permittedInsecurePackages = [
          # Добавляй только при необходимости
        ];
      };
      
      # Стабильные пакеты с оптимизациями
      pkgs = import nixpkgs {
        inherit system;
        config = pkgsConfig;
        overlays = [
          # Оптимизации для производительности
          (final: prev: {
            # Оптимизированные Mesa драйверы для AMD/Intel
            mesa = prev.mesa.override {
              galliumDrivers = [ "radeonsi" "swrast" "iris" "crocus" ];
              vulkanDrivers = [ "amd" "intel" ];
            };
          })
        ];
      };
      
      # Unstable пакеты
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = pkgsConfig;
      };
      
      # Универсальная аппаратная конфигурация
      hardwareModules = [
        # Общие оптимизации
        hardware.nixosModules.common-pc
        hardware.nixosModules.common-pc-ssd
        
        # Поддержка AMD CPU (автоматическая оптимизация)
        hardware.nixosModules.common-cpu-amd
        hardware.nixosModules.common-cpu-amd-pstate
        
        # Поддержка Intel CPU (на случай смены железа)
        # hardware.nixosModules.common-cpu-intel
        
        # Поддержка AMD GPU
        hardware.nixosModules.common-gpu-amd
        
        # Поддержка NVIDIA (закомментировано, раскомментируй при необходимости)
        # hardware.nixosModules.common-gpu-nvidia-nonprime
        # hardware.nixosModules.common-gpu-nvidia-disable
      ];
      
      # Аргументы для модулей
      specialArgs = {
        inherit inputs pkgs-unstable hardware;
      };
    in
    {
      # Конфигурации системы
      nixosConfigurations = {
        # Основная конфигурация
        yukishidzu = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          
          modules = hardwareModules ++ [
            # Основные конфигурации
            ./configuration.nix
            ./hardware-configuration.nix
            
            # Home Manager с оптимизациями
            home-manager.nixosModules.home-manager
            
            # Темы
            catppuccin.nixosModules.catppuccin
            
            # Конфигурация оптимизаций
            {
              # Nix настройки для производительности
              nix = {
                settings = {
                  # Основные настройки
                  experimental-features = [ "nix-command" "flakes" ];
                  auto-optimise-store = true;
                  
                  # Оптимизация binary cache
                  trusted-users = [ "root" "@wheel" ];
                  substituters = [
                    "https://cache.nixos.org"
                    "https://hyprland.cachix.org"
                    "https://nix-community.cachix.org" 
                    "https://cuda-maintainers.cachix.org"  # На случай NVIDIA
                  ];
                  trusted-public-keys = [
                    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                    "hyprland.cachix.org-1:a7T5J9HO2A9q/jrANF6F0hFCCTKjN9vE2Dx6q2Lr4Z8="
                    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
                    "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrwrelGdILs9kl3mJbrOWdU="
                  ];
                  
                  # Оптимизация производительности
                  max-jobs = "auto";
                  cores = 0;  # Использовать все ядра
                };
                
                # Оптимизированная сборка мусора
                gc = {
                  automatic = true;
                  dates = "daily";
                  options = "--delete-older-than 3d";
                };
                
                # Оптимизация хранилища
                optimise = {
                  automatic = true;
                  dates = [ "weekly" ];
                };
              };
              
              # Home Manager конфигурация
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                
                extraSpecialArgs = { 
                  inherit inputs pkgs-unstable;
                };
                
                users.yukishidzu = import ./home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
        
        # Дополнительные конфигурации (примеры)
        # yukishidzu-minimal = минимальная конфигурация
        # yukishidzu-server = серверная конфигурация
      };
      
      # Оптимизированная среда разработки
      devShells.${system} = {
        default = pkgs.mkShell {
          name = "nixos-config-dev";
          
          packages = with pkgs; [
            nixpkgs-fmt
            nil  # LSP
            git
            home-manager
            # Дополнительные утилиты для отладки
            nix-tree  # анализ зависимостей
            nix-du    # анализ размера стора
          ];
          
          shellHook = ''
            echo "🚀 Оптимизированная среда разработки NixOS"
            echo "📝 nix fmt .                                    - форматировать код"
            echo "🔨 nix flake check                              - проверить конфигурацию"
            echo "🔄 sudo nixos-rebuild switch --flake .#yukishidzu - применить систему"
            echo "🏠 home-manager switch --flake .#yukishidzu       - применить пользователя"
            echo "📈 nix-du -s 500MB /nix/store                    - анализ размера"
            echo "🌳 nix-tree                                     - анализ зависимостей"
          '';
        };
      };
      
      # Форматер кода
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
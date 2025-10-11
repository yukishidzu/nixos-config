{
  description = "Yukishidzu's NixOS Configuration";
  
  inputs = {
    # Стабильный канал для системы
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    # Unstable для свежих пакетов (Cursor IDE и др.)
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Темы Catppuccin
    catppuccin.url = "github:catppuccin/nix";
    
    # Hyprland (раскомментируй если хочешь свежайшую версию)
    # hyprland = {
    #   url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      
      # Стабильные пакеты
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          # Разрешаем небезопасные пакеты если нужно
          permittedInsecurePackages = [
            # "electron-25.9.0"  # Пример
          ];
        };
      };
      
      # Unstable пакеты
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      
      # Специальные аргументы для модулей
      specialArgs = {
        inherit inputs pkgs-unstable;
      };
    in
    {
      nixosConfigurations = {
        yukishidzu = nixpkgs.lib.nixosSystem {
          inherit system specialArgs;
          
          modules = [
            # Основная конфигурация системы
            ./configuration.nix
            
            # Home Manager как модуль NixOS
            home-manager.nixosModules.home-manager
            
            # Темы Catppuccin для системы
            catppuccin.nixosModules.catppuccin
            
            # Настройка Home Manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                
                # Передаём unstable в Home Manager
                extraSpecialArgs = { 
                  inherit inputs pkgs-unstable;
                };
                
                # Конфигурация пользователя
                users.yukishidzu = import ./home.nix;
                
                # Бэкап старых поколений (опционально)
                backupFileExtension = "backup";
              };
              
              # Включаем экспериментальные фичи Nix
              nix = {
                settings = {
                  experimental-features = [ "nix-command" "flakes" ];
                  # Оптимизация хранилища
                  auto-optimise-store = true;
                };
                
                # Автоматическая сборка мусора
                gc = {
                  automatic = true;
                  dates = "weekly";
                  options = "--delete-older-than 7d";
                };
              };
            }
          ];
        };
      };
      
      # Форматер для `nix fmt`
      formatter.${system} = pkgs.nixpkgs-fmt;
      
      # Dev shell для разработки конфигурации (опционально)
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          nixpkgs-fmt
          nil  # LSP для Nix
          git
        ];
        
        shellHook = ''
          echo "🚀 NixOS Configuration Development Shell"
          echo "📝 nix fmt - форматировать код"
          echo "🔨 nix flake check - проверить конфигурацию"
          echo "🔄 sudo nixos-rebuild switch --flake .#yukishidzu - применить"
        '';
      };
    };
}

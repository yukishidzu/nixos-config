{ config, pkgs, lib, ... }:

{
  # Основные языки программирования
  environment.systemPackages = with pkgs; [
    # Python
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.poetry
    
    # Node.js
    nodejs_20
    nodePackages.npm
    nodePackages.yarn
    nodePackages.pnpm
    
    # Rust
    rustc
    cargo
    rust-analyzer
    
    # Go
    go
    gopls
    
    # Java
    jdk17
    maven
    gradle
    
    # C/C++
    gcc
    gnumake
    cmake
    ninja
    clang
    clang-tools
    
    # Дополнительные инструменты
    git
    git-lfs
    gh
    docker
    docker-compose
    kubernetes-helm
    kubectl
    
    # Базы данных
    postgresql
    redis
    mongodb
    
    # Мониторинг и логи
    prometheus
    grafana
    elasticsearch
    kibana
    
    # CI/CD
    jenkins
    gitlab-runner
    
    # Дополнительные утилиты
    jq
    yq
    httpie
    curl
    wget
    rsync
    tmux
    screen
  ];

  # Настройки для разработки
  programs = {
    # Git настройки
    git = {
      enable = true;
      config = {
        user.name = "yukishidzu";
        user.email = "yukishidzu@example.com";
        init.defaultBranch = "main";
        pull.rebase = true;
        push.autoSetupRemote = true;
      };
    };

    # Docker настройки
    docker = {
      enable = true;
      autoPrune.enable = true;
      autoPrune.dates = "weekly";
    };
  };

  # Сервисы для разработки
  services = {
    # PostgreSQL
    postgresql = {
      enable = false; # Включать только если нужно
      package = pkgs.postgresql_15;
      enableTCPIP = true;
      settings = {
        max_connections = 100;
        shared_buffers = "256MB";
        effective_cache_size = "1GB";
        maintenance_work_mem = "64MB";
        checkpoint_completion_target = 0.9;
        wal_buffers = "16MB";
        default_statistics_target = 100;
        random_page_cost = 1.1;
        effective_io_concurrency = 200;
        work_mem = "4MB";
        min_wal_size = "1GB";
        max_wal_size = "4GB";
      };
    };

    # Redis
    redis = {
      enable = false; # Включать только если нужно
      settings = {
        maxmemory = "256mb";
        maxmemory-policy = "allkeys-lru";
      };
    };
  };
}

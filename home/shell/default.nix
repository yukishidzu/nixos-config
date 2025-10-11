{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  # Fish shell конфигурация
  programs.fish = {
    enable = true;
    
    # Псевдонимы для удобства
    shellAliases = {
      # Основные команды
      ls = "eza --color=always --group-directories-first";
      ll = "eza -la --color=always --group-directories-first";
      lt = "eza -aT --color=always --group-directories-first";
      cat = "bat";
      grep = "rg";
      find = "fd";
      
      # Git сокращения
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";
      
      # NixOS команды
      rebuild = "sudo nixos-rebuild switch --flake .#yukishidzu";
      home-rebuild = "home-manager switch --flake .#yukishidzu";
      update-flake = "nix flake update";
      
      # Системные утилиты
      btop = "btop --utf-force";
      neofetch = "fastfetch";
    };
    
    # Интерактивная конфигурация
    interactiveShellInit = ''
      # Переменные окружения
      set -gx EDITOR "cursor"
      set -gx BROWSER "firefox"
      set -gx TERMINAL "kitty"
      
      # FZF настройки
      set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --border --margin=1 --padding=1"
      set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
      
      # Цветовая схема ls
      set -gx LS_COLORS "di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33:cd=1;33:su=1;37:sg=1;37:tw=1;34:ow=1;34"
      
      # Приветствие
      if status is-interactive
          echo "🎉 Настроение завершено! Добро пожаловать в NixOS!"
          fastfetch
      end
    '';
  };
  
  # Starship prompt
  programs.starship = {
    enable = true;
    settings = {
      # Основные настройки
      format = lib.concatStrings [
        "$all"
        "$character"
      ];
      
      # Настройки компонентов
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
      };
      
      directory = {
        style = "blue bold";
        truncation_length = 4;
        truncate_to_repo = false;
      };
      
      git_branch = {
        symbol = "🌊 ";
        style = "bright-purple";
      };
      
      git_status = {
        style = "bright-red";
        conflicted = "🏳";
        ahead = "🏎💨";
        behind = "😰";
        diverged = "😵";
        untracked = "🤷";
        stashed = "📦";
        modified = "📝";
        staged = "➕";
        renamed = "👅";
        deleted = "🗑";
      };
      
      nix_shell = {
        symbol = "❄️ ";
        style = "bright-blue";
      };
    };
  };
  
  # Bash (на случай фолбэка)
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      # Простая конфигурация bash
      export EDITOR="cursor"
      export BROWSER="firefox"
      export TERMINAL="kitty"
    '';
  };
  
  # Общие программы для shell
  home.packages = with pkgs; [
    # Модерные замены классическим утилитам
    eza          # ls
    bat          # cat  
    ripgrep      # grep
    fd           # find
    fzf          # fuzzy finder
    zoxide       # cd
    fastfetch    # neofetch
    btop         # htop
    
    # Разработка
    git
    gh           # GitHub CLI
    tree
    jq           # JSON processor
    
    # Архивы
    unzip
    zip
    p7zip
    
    # Сеть
    wget
    curl
    rsync
  ];
  
  # Переменные окружения
  home.sessionVariables = {
    EDITOR = "cursor";
    BROWSER = "firefox"; 
    TERMINAL = "kitty";
    PAGER = "less";
    MANPAGER = "less";
  };
}
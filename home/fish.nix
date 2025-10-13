{ config, pkgs, lib, ... }:

{
  programs.fish = {
    enable = true;
    # Интерактивная конфигурация fish
    interactiveShellInit = ''
      set -g fish_greeting ""
      set -g theme_nerd_fonts yes
      
      # Отключаем стандартный prompt, старшип будет управлять
      # Полезные алиасы
      alias ll "eza -la --icons"
      alias la "eza -a --icons"
      alias ls "eza --icons"
      alias tree "eza --tree --icons"
      alias cat "bat"
      alias grep "rg"
      alias find "fd"
    '';
    
    # Плагины и функции
    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      backup = "cp $argv $argv.backup";
    };
  };

  # Starship prompt - минималистичный и красивый
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  # Starship конфигурация - Catppuccin Mocha
  xdg.configFile."starship.toml".text = ''
    format = """$username$hostname$directory$git_branch$git_status$cmd_duration$character"""
    
    [username]
    style_user = "bold blue"
    style_root = "bold red"
    format = "[$user]($style) "
    disabled = false
    show_always = true
    
    [hostname]
    ssh_only = false
    format = "on [$hostname](bold yellow) "
    disabled = false
    
    [directory]
    style = "bold cyan"
    format = "in [$path]($style) "
    truncation_length = 3
    truncation_symbol = "…/"
    
    [git_branch]
    symbol = " "
    style = "bold purple"
    format = "[$symbol$branch]($style) "
    
    [git_status]
    style = "bold red"
    format = "([$all_status$ahead_behind]($style) )"
    
    [cmd_duration]
    min_time = 2000
    style = "bold yellow"
    format = "took [$duration]($style) "
    
    [character]
    success_symbol = "[](bold green)"
    error_symbol = "[](bold red)"
    
    # Catppuccin Mocha цветовая схема
    [palettes.catppuccin_mocha]
    rosewater = "#f5e0dc"
    flamingo = "#f2cdcd"
    pink = "#f5c2e7"
    mauve = "#cba6f7"
    red = "#f38ba8"
    maroon = "#eba0ac"
    peach = "#fab387"
    yellow = "#f9e2af"
    green = "#a6e3a1"
    teal = "#94e2d5"
    sky = "#89dceb"
    sapphire = "#74c7ec"
    blue = "#89b4fa"
    lavender = "#b4befe"
    text = "#cdd6f4"
    subtext1 = "#bac2de"
    subtext0 = "#a6adc8"
    overlay2 = "#9399b2"
    overlay1 = "#7f849c"
    overlay0 = "#6c7086"
    surface2 = "#585b70"
    surface1 = "#45475a"
    surface0 = "#313244"
    base = "#1e1e2e"
    mantle = "#181825"
    crust = "#11111b"
    
    palette = "catppuccin_mocha"
  '';

  # Пакеты для fish
  home.packages = with pkgs; [ fish starship eza bat ripgrep fd ];
}

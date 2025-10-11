{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  # Fish shell конфигурация (только на уровне пользователя)
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --color=always --group-directories-first";
      ll = "eza -la --color=always --group-directories-first";
      lt = "eza -aT --color=always --group-directories-first";
      cat = "bat";
      grep = "rg";
      find = "fd";
      g = "git"; gs = "git status"; ga = "git add"; gc = "git commit"; gp = "git push"; gl = "git log --oneline";
      rebuild = "sudo nixos-rebuild switch --flake .#yukishidzu";
      home-rebuild = "home-manager switch --flake .#yukishidzu";
      update-flake = "nix flake update";
      btop = "btop --utf-force";
      neofetch = "fastfetch";
    };
    interactiveShellInit = ''
      set -gx EDITOR "cursor"
      set -gx BROWSER "firefox"
      set -gx TERMINAL "kitty"
      set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --border --margin=1 --padding=1"
      set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --follow --exclude .git"
      set -gx LS_COLORS "di=1;34:ln=1;36:so=1;35:pi=1;33:ex=1;32:bd=1;33:cd=1;33:su=1;37:sg=1;37:tw=1;34:ow=1;34"
      if status is-interactive
          echo "🎉 Готово! Добро пожаловать в NixOS!"
          fastfetch
      end
    '';
  };

  programs.starship = {
    enable = true;
    settings = {
      format = lib.concatStrings [ "$all" "$character" ];
      character = { success_symbol = "[❯](bold green)"; error_symbol = "[❯](bold red)"; };
      directory = { style = "blue bold"; truncation_length = 4; truncate_to_repo = false; };
      git_branch = { symbol = "🌊 "; style = "bright-purple"; };
      git_status = { style = "bright-red"; conflicted = "🏳"; ahead = "🏎💨"; behind = "😰"; diverged = "😵"; untracked = "🤷"; stashed = "📦"; modified = "📝"; staged = "➕"; renamed = "👅"; deleted = "🗑"; };
      nix_shell = { symbol = "❄️ "; style = "bright-blue"; };
    };
  };

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export EDITOR="cursor"
      export BROWSER="firefox"
      export TERMINAL="kitty"
    '';
  };

  home.packages = with pkgs; [
    eza bat ripgrep fd fzf zoxide fastfetch btop
    git gh tree jq unzip zip p7zip wget curl rsync
  ];

  home.sessionVariables = {
    EDITOR = "cursor";
    BROWSER = "firefox";
    TERMINAL = "kitty";
    PAGER = "less";
    MANPAGER = "less";
  };
}

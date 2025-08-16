{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    
    # Красивая конфигурация в стиле Catppuccin Mocha
    settings = {
      # Формат приглашения
      format = "$all";
      
      # Добавляем новую строку в конце
      add_newline = true;
      
      # Настройки для различных модулей
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
        vicmd_symbol = "[❮](bold blue)";
      };
      
      directory = {
        style = "blue bold";
        truncation_length = 3;
        truncation_symbol = "…/";
        home_symbol = "🏠";
      };
      
      git_branch = {
        symbol = " ";
        style = "purple bold";
        truncation_length = 4;
        truncation_symbol = "";
      };
      
      git_status = {
        style = "red bold";
        ahead = "⇡\${count}";
        behind = "⇣\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        untracked = "?";
        stashed = "≡";
        modified = "!";
        staged = "+";
        renamed = "»";
        deleted = "✘";
      };
      
      git_commit = {
        commit_hash_length = 4;
        style = "green bold";
      };
      
      git_state = {
        style = "red";
        rebase = "REBASE";
        merge = "MERGE";
        revert = "REVERT";
        cherry_pick = "CHERRY-PICK";
        bisect = "BISECT";
        am = "AM";
        am_or_rebase = "AM/REBASE";
        progress_divider = "/";
        progress = "\${current}/\${total}";
      };
      
      package = {
        symbol = "📦 ";
        style = "red bold";
      };
      
      nodejs = {
        symbol = " ";
        style = "green bold";
      };
      
      python = {
        symbol = " ";
        style = "yellow bold";
      };
      
      rust = {
        symbol = " ";
        style = "red bold";
      };
      
      golang = {
        symbol = " ";
        style = "cyan bold";
      };
      
      java = {
        symbol = " ";
        style = "red dimmed";
      };
      
      docker_context = {
        symbol = " ";
        style = "blue bold";
      };
      
      aws = {
        symbol = " ";
        style = "yellow bold";
      };
      
      gcloud = {
        symbol = " ";
        style = "blue bold";
      };
      
      kubernetes = {
        symbol = " ";
        style = "blue bold";
      };
      
      terraform = {
        symbol = " ";
        style = "purple bold";
      };
      
      nix_shell = {
        symbol = " ";
        style = "blue bold";
      };
      
      cmd_duration = {
        min_time = 2000;
        style = "yellow";
      };
      
      time = {
        disabled = false;
        format = "%T";
        style = "bright-black";
        time_format = "%T";
        utc_time_offset = "local";
      };
      
      username = {
        style_user = "bright-white bold";
        style_root = "red bold";
        format = "[\$user](\$style) ";
        disabled = false;
        show_always = true;
      };
      
      hostname = {
        ssh_only = false;
        format = "[\$hostname](\$style) ";
        disabled = false;
      };
      
      memory_usage = {
        symbol = " ";
        style = "white bold";
        disabled = false;
        threshold = 75;
      };
      
      battery = {
        full_symbol = " ";
        charging_symbol = " ";
        discharging_symbol = " ";
        unknown_symbol = " ";
        empty_symbol = " ";
        format = "[\$symbol\$percentage](\$style) ";
        disabled = false;
        max_percentage = 100;
        charging_threshold = 10;
        discharging_threshold = 5;
        low_threshold = 10;
        charging_style = "green bold";
        discharging_style = "red bold";
        unknown_style = "yellow bold";
        empty_style = "red bold";
        low_style = "red bold";
      };
      
      status = {
        symbol = " ";
        style = "red bold";
        disabled = false;
        recognize_signal_code = true;
        map_symbol = true;
        pipestatus = true;
        pipestatus_separator = "|";
        pipestatus_format = "[\$pipestatus] => [\$symbol\$common_name\$signal_name](\$style) ";
        pipestatus_separator_format = " ";
      };
      
      jobs = {
        symbol = " ";
        style = "bright-black";
        number_threshold = 1;
        symbol_threshold = 0;
        disabled = false;
      };
      
      # Настройки для различных языков программирования
      [git_metrics]
      disabled = false;
      added_style = "bold green";
      deleted_style = "bold red";
      
      [c]
      symbol = " ";
      style = "blue bold";
      
      [cpp]
      symbol = " ";
      style = "blue bold";
      
      [csharp]
      symbol = " ";
      style = "blue bold";
      
      [dart]
      symbol = " ";
      style = "blue bold";
      
      [deno]
      symbol = " ";
      style = "yellow bold";
      
      [elixir]
      symbol = " ";
      style = "purple bold";
      
      [elm]
      symbol = " ";
      style = "blue bold";
      
      [erlang]
      symbol = " ";
      symbol = " ";
      style = "red bold";
      
      [haskell]
      symbol = " ";
      style = "red bold";
      
      [julia]
      symbol = " ";
      style = "purple bold";
      
      [kotlin]
      symbol = " ";
      style = "blue bold";
      
      [lua]
      symbol = " ";
      style = "blue bold";
      
      [nim]
      symbol = " ";
      style = "yellow bold";
      
      [ocaml]
      symbol = " ";
      style = "yellow bold";
      
      [perl]
      symbol = " ";
      style = "red bold";
      
      [php]
      symbol = " ";
      style = "blue bold";
      
      [purescript]
      symbol = " ";
      style = "white bold";
      
      [r]
      symbol = " ";
      style = "blue bold";
      
      [ruby]
      symbol = " ";
      style = "red bold";
      
      [scala]
      symbol = " ";
      style = "red bold";
      
      [swift]
      symbol = " ";
      style = "green bold";
      
      [zig]
      symbol = " ";
      style = "yellow bold";
    };
  };
}

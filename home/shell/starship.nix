{ config, pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    catppuccin.enable = true;
    
    settings = {
      add_newline = false;
      format = "$all$character";
      
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      
      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
      };
      
      git_branch = {
        symbol = " ";
      };
      
      nodejs = {
        symbol = " ";
      };
      
      python = {
        symbol = " ";
      };
      
      nix_shell = {
        symbol = " ";
      };
    };
  };
}

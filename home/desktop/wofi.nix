{ config, pkgs, lib, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      width = 400;
      height = 300;
      location = "center";
      show = "drun";
      prompt = "Search";
      filter_rate = 100;
      allow_markup = true;
      no_actions = false;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
      }
      
      window {
        background-color: rgba(30, 30, 46, 0.8);
        border: 2px solid #89b4fa;
        border-radius: 10px;
      }
      
      #input {
        margin: 5px;
        border: none;
        color: #cdd6f4;
        background-color: #313244;
        border-radius: 5px;
      }
      
      #inner-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }
      
      #outer-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }
      
      #scroll {
        margin: 0px;
        border: none;
      }
      
      #text {
        margin: 5px;
        border: none;
        color: #cdd6f4;
      }
      
      #entry {
        background-color: transparent;
        border: none;
        border-radius: 5px;
      }
      
      #entry:selected {
        background-color: #89b4fa;
        color: #1e1e2e;
      }
      
      #entry:selected #text {
        color: #1e1e2e;
      }
    '';
  };
}

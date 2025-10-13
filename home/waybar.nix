{ config, pkgs, lib, ... }:

{
  # Waybar enable (HM-managed service)
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    # Provide minimal JSON config and Catppuccin CSS via xdg.configFile below
  };

  # Declarative Waybar config and style (Catppuccin Mocha, minimal, not pitch black)
  xdg.configFile = {
    "waybar/config.jsonc".text = ''
      // Minimalist Waybar config
      {
        "layer": "top",
        "position": "top",
        "height": 28,
        "margin": "6 8 0 8",
        "modules-left": ["hyprland/workspaces"],
        "modules-center": ["clock"],
        "modules-right": ["pulseaudio", "backlight", "battery", "tray"],

        "hyprland/workspaces": {
          "on-click": "activate",
          "format": "{name}",
          "sort-by-number": true,
          "all-outputs": true
        },

        "clock": {
          "format": "{:%a, %d %b  %H:%M}",
          "tooltip": true,
          "tooltip-format": "{:%A, %d %B %Y}"
        },

        "pulseaudio": {
          "format": "{icon} {volume}%",
          "format-muted": "  {volume}%",
          "on-click": "pavucontrol",
          "format-icons": {"default": ["", "", ""]}
        },

        "backlight": {
          "format": "  {percent}%",
          "interval": 2
        },

        "battery": {
          "format": "{icon} {capacity}%",
          "format-icons": ["", "", "", "", ""],
          "states": {"warning": 25, "critical": 10}
        },

        "tray": {"icon-size": 16}
      }
    '';

    "waybar/style.css".text = ''
      /* Catppuccin Mocha minimal Waybar */
      @define-color base   #1E1E2E;
      @define-color mantle #181825;
      @define-color crust  #11111b;
      @define-color text   #CDD6F4;
      @define-color sub    #A6ADC8;
      @define-color blue   #89B4FA;
      @define-color rose   #F5C2E7;
      @define-color red    #F38BA8;
      @define-color yellow #F9E2AF;
      @define-color green  #A6E3A1;

      * {
        font-family: JetBrainsMono Nerd Font, monospace;
        font-size: 12px;
        color: @text;
      }

      window#waybar {
        background: alpha(@mantle, 0.65);
        border-radius: 12px;
        border: 1px solid alpha(@blue, 0.25);
        box-shadow: 0 8px 24px rgba(0,0,0,0.25);
      }

      .modules-left, .modules-center, .modules-right { padding: 6px 10px; }

      #clock, #battery, #pulseaudio, #backlight, #tray, #workspaces {
        background: alpha(@base, 0.7);
        border: 1px solid alpha(@sub, 0.18);
        border-radius: 10px;
        padding: 4px 8px;
        margin: 0 4px;
      }

      #workspaces button {
        padding: 2px 8px; margin: 0 2px;
        color: @sub; background: transparent;
        border: 1px solid transparent; border-radius: 8px;
        transition: all 120ms ease-in-out;
      }
      #workspaces button.active { color: @text; border-color: alpha(@blue,0.4); background: alpha(@blue,0.12); }
      #workspaces button:hover  { color: @text; border-color: alpha(@blue,0.4); }

      #battery.warning { color: @yellow; }
      #battery.critical { color: @red; }
    '';
  };

  # Runtime deps Waybar modules use
  home.packages = with pkgs; [ pavucontrol brightnessctl ];
}

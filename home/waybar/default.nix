{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  # Waybar конфигурация - единый экземпляр через Home Manager
  programs.waybar = {
    enable = true;
    systemd.enable = true;  # Запуск через systemd user service
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 28;
        spacing = 4;
        
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "cpu" "memory" "temperature" "network" "pulseaudio" "battery" "tray" ];
        
        # Рабочие столы
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "0";
          };
        };
        
        # Активное окно
        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };
        
        # Часы
        clock = {
          timezone = "Europe/Moscow";
          format = "{:%H:%M}";
          format-alt = "{:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        
        # CPU
        cpu = {
          format = "󰻠 {usage}%";
          tooltip = false;
        };
        
        # Память
        memory = {
          format = "󰍛 {used}G";
          tooltip-format = "Used: {used}GiB\nAvailable: {avail}GiB\nTotal: {total}GiB";
        };
        
        # Температура
        temperature = {
          critical-threshold = 80;
          format = "{icon} {temperatureC}°C";
          format-icons = [ "" "" "" "" "" ];
        };
        
        # Сеть
        network = {
          format-wifi = "󰖙 {essid}";
          format-ethernet = "󰈀 Connected";
          format-linked = "󰈀 Linked";
          format-disconnected = "󰤭 Offline";
          tooltip-format-wifi = "Signal: {signalStrength}%\nIP: {ipaddr}/{cidr}";
          tooltip-format-ethernet = "IP: {ipaddr}/{cidr}";
        };
        
        # Звук
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon}󰂯 {volume}%";
          format-bluetooth-muted = "󰖁󰂯";
          format-muted = "󰖁";
          format-source = "󰍬 {volume}%";
          format-source-muted = "󰍭";
          
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋎";
            headset = "󰋋";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          
          on-click = "pavucontrol";
        };
        
        # Батарея
        battery = {
          bat = "BAT0";
          adapter = "ADP1";
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰚥 {capacity}%";
          format-alt = "{icon} {time}";
          
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        };
        
        # Системный трей
        tray = {
          spacing = 8;
        };
      };
    };
    
    # Минималистичные стили Catppuccin Mocha
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-weight: 500;
        font-size: 12px;
        min-height: 0;
      }
      
      window#waybar {
        background-color: rgba(30, 30, 46, 0.95);
        color: #cdd6f4;
        border-bottom: 1px solid rgba(137, 180, 250, 0.3);
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      
      #workspaces {
        margin: 0 4px;
      }
      
      #workspaces button {
        padding: 2px 8px;
        margin: 2px 1px;
        background-color: rgba(69, 71, 90, 0.4);
        color: #cdd6f4;
        border-radius: 4px;
        transition: all 0.3s ease;
        min-width: 20px;
      }
      
      #workspaces button.active {
        background-color: #89b4fa;
        color: #1e1e2e;
        box-shadow: inset 0 -2px 0 #89b4fa;
      }
      
      #workspaces button:hover {
        background-color: rgba(69, 71, 90, 0.8);
        color: #cdd6f4;
      }
      
      #window {
        margin: 0 8px;
        color: #a6adc8;
        font-weight: normal;
      }
      
      #clock {
        color: #89b4fa;
        font-weight: bold;
        margin: 0 8px;
      }
      
      #cpu, #memory, #temperature, #network, #pulseaudio, #battery, #tray {
        padding: 2px 8px;
        margin: 2px 2px;
        border-radius: 4px;
        background-color: rgba(69, 71, 90, 0.3);
      }
      
      #cpu {
        color: #fab387;
      }
      
      #memory {
        color: #f9e2af;
      }
      
      #temperature {
        color: #cba6f7;
      }
      
      #temperature.critical {
        color: #f38ba8;
        background-color: rgba(243, 139, 168, 0.2);
      }
      
      #network {
        color: #a6e3a1;
      }
      
      #network.disconnected {
        color: #f38ba8;
      }
      
      #pulseaudio {
        color: #94e2d5;
      }
      
      #pulseaudio.muted {
        color: #6c7086;
      }
      
      #battery {
        color: #a6e3a1;
      }
      
      #battery.warning:not(.charging) {
        color: #f9e2af;
        background-color: rgba(249, 226, 175, 0.1);
      }
      
      #battery.critical:not(.charging) {
        color: #f38ba8;
        background-color: rgba(243, 139, 168, 0.1);
        animation: blink 0.5s linear infinite alternate;
      }
      
      @keyframes blink {
        to {
          background-color: rgba(243, 139, 168, 0.3);
        }
      }
      
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: rgba(243, 139, 168, 0.2);
      }
    '';
  };
}
{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  # Waybar конфигурация
  programs.waybar = {
    enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 35;
        
        modules-left = [ "hyprland/workspaces" "hyprland/mode" ];
        modules-center = [ "clock" ];
        modules-right = [ "network" "pulseaudio" "battery" "tray" ];
        
        # Рабочие столы
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        
        # Часы
        clock = {
          timezone = "Europe/Moscow";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        
        # Сеть
        network = {
          format-wifi = "📶 {essid} ({signalStrength}%)";
          format-ethernet = "🌐 {ifname}";
          format-linked = "🌐 {ifname} (No IP)";
          format-disconnected = "❌ Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "📶 {essid} ({signalStrength}%) via {gwaddr}";
        };
        
        # Звук
        pulseaudio = {
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% 🔵";
          format-bluetooth-muted = "🔇 {icon} 🔵";
          format-muted = "🔇 {format_source}";
          format-source = "🎤 {volume}%";
          format-source-muted = "🔇";
          
          format-icons = {
            headphone = "🎧";
            hands-free = "🎙️";
            headset = "🎧";
            phone = "📱";
            portable = "📱";
            car = "🚗";
            default = [ "🔈" "🔉" "🔊" ];
          };
          
          on-click = "pavucontrol";
        };
        
        # Батарея
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "⚡ {capacity}%";
          format-plugged = "🔌 {capacity}%";
          format-alt = "{icon} {time}";
          
          format-icons = [ "🔋" "🔋" "🔋" "🔋" "🔋" ];
        };
        
        # Системный трей
        tray = {
          spacing = 10;
        };
      };
    };
    
    # Стили
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-weight: bold;
        font-size: 14px;
        min-height: 0;
      }
      
      window#waybar {
        background: rgba(30, 30, 46, 0.9);
        color: #cdd6f4;
      }
      
      #workspaces button {
        padding: 5px 10px;
        background: transparent;
        color: #cdd6f4;
      }
      
      #workspaces button.active {
        background: #89b4fa;
        color: #1e1e2e;
      }
      
      #workspaces button:hover {
        background: #45475a;
        color: #cdd6f4;
      }
      
      #clock, #network, #pulseaudio, #battery, #tray {
        padding: 0 10px;
        margin: 3px 0;
      }
      
      #clock {
        color: #89b4fa;
      }
      
      #network {
        color: #a6e3a1;
      }
      
      #pulseaudio {
        color: #f9e2af;
      }
      
      #battery {
        color: #fab387;
      }
      
      #battery.warning {
        color: #f9e2af;
      }
      
      #battery.critical {
        color: #f38ba8;
      }
    '';
  };
}
{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 4;
        
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "hyprland/language" ];
        modules-right = [ "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "temperature" "backlight" "battery" "clock" "tray" ];
        
        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{icon}";
          format-icons = {
            "1" = "󰈹";
            "2" = "󰈹";
            "3" = "󰈹";
            "4" = "󰈹";
            "5" = "󰈹";
            "6" = "󰈹";
            "7" = "󰈹";
            "8" = "󰈹";
            "9" = "󰈹";
            "10" = "󰈹";
            "urgent" = "󰈹";
            "focused" = "󰈹";
            "default" = "󰈹";
          };
        };
        
        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
        };
        
        "hyprland/language" = {
          format = "󰌌 {}";
          format-eng = "EN";
          format-rus = "RU";
        };
        
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰒳";
            deactivated = "󰒲";
          };
        };
        
        tray = {
          spacing = 10;
        };
        
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
        
        cpu = {
          format = "{usage}% 󰻠";
          tooltip = false;
        };
        
        memory = {
          format = "{}% 󰍛";
        };
        
        temperature = {
          thermal-zone = 2;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [ "󰤉" "󰤨" "󰤩" ];
        };
        
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
        };
        
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰂄";
          format-alt = "{time} {icon}";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰂃" ];
        };
        
        network = {
          format-wifi = "{essid} ({signalStrength}%) 󰤨";
          format-ethernet = "{ipaddr}/{cidr} 󰤨";
          tooltip-format = "{ifname} via {gwaddr} 󰤨";
          format-linked = "{ifname} (No IP) 󰤨";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
        };
        
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon}󰂯 {format_source}";
          format-bluetooth-muted = "󰂲 {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "{volume}% 󰍬";
          format-source-muted = "󰍭";
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋋";
            headset = "󰋋";
            phone = "󰄜";
            portable = "󰦧";
            car = "󰄋";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
        font-size: 13px;
        min-height: 0;
      }
      
      window#waybar {
        background: rgba(30, 30, 46, 0.5);
        color: #cdd6f4;
      }
      
      tooltip {
        background: #1e1e2e;
        border: 1px solid #89b4fa;
        border-radius: 10px;
      }
      
      #workspaces button {
        padding: 0 5px;
        background: transparent;
        color: #cdd6f4;
      }
      
      #workspaces button.focused {
        background: #89b4fa;
        color: #1e1e2e;
      }
      
      #workspaces button.urgent {
        background: #f38ba8;
        color: #1e1e2e;
      }
      
      #window {
        background: transparent;
        color: #cdd6f4;
      }
      
      #language {
        background: transparent;
        color: #cdd6f4;
      }
      
      #idle_inhibitor {
        background: transparent;
        color: #cdd6f4;
      }
      
      #tray {
        background: transparent;
      }
      
      #clock {
        background: transparent;
        color: #cdd6f4;
      }
      
      #cpu {
        background: transparent;
        color: #cdd6f4;
      }
      
      #memory {
        background: transparent;
        color: #cdd6f4;
      }
      
      #temperature {
        background: transparent;
        color: #cdd6f4;
      }
      
      #backlight {
        background: transparent;
        color: #cdd6f4;
      }
      
      #battery {
        background: transparent;
        color: #cdd6f4;
      }
      
      #network {
        background: transparent;
        color: #cdd6f4;
      }
      
      #pulseaudio {
        background: transparent;
        color: #cdd6f4;
      }
    '';
  };
}

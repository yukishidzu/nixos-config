{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    catppuccin.enable = true;
    
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 0;
        margin-top = 4;
        margin-bottom = 0;
        margin-left = 8;
        margin-right = 8;
        
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "network" "battery" "tray" ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          sort-by-number = true;
          active-only = false;
          all-outputs = false;
          persistent-workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
          };
        };

        "hyprland/window" = {
          format = "{}";
          separate-outputs = true;
          max-length = 50;
          rewrite = {
            "(.*) — Mozilla Firefox" = " $1";
            "(.*) - Visual Studio Code" = " $1";
            "(.*) — Nemo" = " $1";
          };
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          actions = {
            on-click-right = "mode";
          };
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
          tooltip = false;
        };

        network = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-linked = "{ifname} (No IP) ";
          format-disconnected = "Disconnected ⚠";
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          tooltip-format = "{ifname} via {gwaddr} ";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "nm-connection-editor";
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "pavucontrol";
          tooltip = false;
        };

        tray = {
          spacing = 10;
          icon-size = 18;
        };
      };
    };
    
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", monospace;
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: rgba(30, 30, 46, 0.8);
        border-radius: 8px;
        border: 2px solid rgba(137, 180, 250, 0.3);
        color: #cdd6f4;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      #workspaces {
        background: transparent;
        margin: 4px 4px 4px 8px;
        padding: 0px 0px;
        border-radius: 8px;
      }

      #workspaces button {
        padding: 0px 8px;
        margin: 0px 2px;
        border-radius: 6px;
        background: rgba(88, 91, 112, 0.3);
        color: #cdd6f4;
        border: 1px solid rgba(137, 180, 250, 0.2);
        transition: all 0.3s cubic-bezier(0.55, 0.0, 0.28, 1.0);
      }

      #workspaces button:hover {
        background: rgba(137, 180, 250, 0.3);
        border: 1px solid rgba(137, 180, 250, 0.5);
      }

      #workspaces button.active {
        background: rgba(137, 180, 250, 0.8);
        color: #1e1e2e;
        border: 1px solid rgba(137, 180, 250, 1.0);
      }

      #workspaces button.urgent {
        background: rgba(243, 139, 168, 0.8);
        color: #1e1e2e;
        border: 1px solid rgba(243, 139, 168, 1.0);
      }

      #window {
        background: transparent;
        margin: 4px 0px;
        padding: 0px 12px;
        color: #cdd6f4;
        font-weight: 500;
      }

      #clock {
        background: rgba(116, 199, 236, 0.8);
        color: #1e1e2e;
        margin: 4px 8px;
        padding: 0px 12px;
        border-radius: 6px;
        font-weight: 600;
      }

      #battery,
      #network,
      #pulseaudio,
      #tray {
        background: rgba(88, 91, 112, 0.3);
        margin: 4px 2px;
        padding: 0px 8px;
        border-radius: 6px;
        border: 1px solid rgba(137, 180, 250, 0.2);
        color: #cdd6f4;
      }

      #battery.charging, #battery.plugged {
        background: rgba(166, 227, 161, 0.8);
        color: #1e1e2e;
        border: 1px solid rgba(166, 227, 161, 1.0);
      }

      #battery.critical:not(.charging) {
        background: rgba(243, 139, 168, 0.8);
        color: #1e1e2e;
        border: 1px solid rgba(243, 139, 168, 1.0);
        animation: blink 0.5s linear infinite alternate;
      }

      @keyframes blink {
        to {
          background-color: rgba(243, 139, 168, 0.4);
        }
      }

      #network.disconnected {
        background: rgba(243, 139, 168, 0.8);
        color: #1e1e2e;
      }

      #pulseaudio.muted {
        background: rgba(243, 139, 168, 0.3);
        color: #f38ba8;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
        background-color: rgba(243, 139, 168, 0.8);
      }
    '';
  };
}

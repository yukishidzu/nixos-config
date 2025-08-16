{ config, pkgs, lib, ... }:

{
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };

  # Создаем директорию для конфигурации EWW
  home.file.".config/eww/eww.yuck".text = ''
    (defwidget workspaces []
      (box :class "workspaces"
        (for workspace in (hyprland-workspaces)
          (button :onclick "hyprctl dispatch workspace ''${workspace.id}"
            :class (if (== workspace.id (hyprland-activeworkspace))
              "workspace active"
              "workspace")
            (label :text (if (== workspace.id (hyprland-activeworkspace))
              (format "{}" workspace.name)
              (format "{}" workspace.name)))))))

    (defwidget clock []
      (box :class "clock"
        (label :text (format "{:%H:%M}" (datetime)))))

    (defwidget system []
      (box :class "system"
        (button :onclick "pavucontrol"
          (label :text (format "{}%" (round (* (pulseaudio-volume) 100)))))
        (button :onclick "nm-connection-editor"
          (label :text (format "{}" (network-name))))
        (button :onclick "power-menu"
          (label :text (format "{}%" (round (* (battery-percent) 100)))))))

    (defwindow bar
      :monitor 0
      :windowtype "dock"
      :geometry (geometry :x "0%" :y "0%" :width "100%" :height "32px")
      :stacking "fg"
      (box :class "bar"
        (workspaces)
        (clock)
        (system)))
  '';

  home.file.".config/eww/eww.scss".text = ''
    * {
      all: unset;
      font-family: "JetBrainsMono Nerd Font", monospace;
      font-size: 13px;
    }

    .bar {
      background-color: rgba(30, 30, 46, 0.9);
      border-bottom: 2px solid rgba(137, 180, 250, 0.3);
      padding: 0 16px;
    }

    .workspaces {
      .workspace {
        padding: 8px 12px;
        margin: 0 4px;
        border-radius: 8px;
        background-color: rgba(88, 91, 112, 0.3);
        color: #cdd6f4;
        border: 1px solid rgba(137, 180, 250, 0.2);
        transition: all 0.3s ease;

        &:hover {
          background-color: rgba(137, 180, 250, 0.3);
          border-color: rgba(137, 180, 250, 0.5);
        }

        &.active {
          background-color: rgba(137, 180, 250, 0.8);
          color: #1e1e2e;
          border-color: rgba(137, 180, 250, 1.0);
        }
      }
    }

    .clock {
      padding: 8px 16px;
      background-color: rgba(116, 199, 236, 0.8);
      color: #1e1e2e;
      border-radius: 8px;
      font-weight: 600;
    }

    .system {
      button {
        padding: 8px 12px;
        margin: 0 4px;
        border-radius: 6px;
        background-color: rgba(88, 91, 112, 0.3);
        color: #cdd6f4;
        border: 1px solid rgba(137, 180, 250, 0.2);
        transition: all 0.3s ease;

        &:hover {
          background-color: rgba(137, 180, 250, 0.3);
          border-color: rgba(137, 180, 250, 0.5);
        }
      }
    }
  '';
}

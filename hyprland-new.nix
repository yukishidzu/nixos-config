{ config, pkgs, lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "swww init"
        "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
      bind = lib.mkAfter [
        "SUPER, ESC, exec, wlogout -p layer-shell"
      ];
    };
  };

  # Полностью отключаем hypridle, чтобы исключить влияние на блокировку
  services.hypridle.enable = false;

  # Удаляем hyprlock конфигурацию, оставляя файл пустым (или вовсе без упоминания)
  # Здесь удаляем ранее созданный файл-конфиг, задав пустой текст (HM удалит линк)
  xdg.configFile."hypr/hyprlock.conf".text = "";
}

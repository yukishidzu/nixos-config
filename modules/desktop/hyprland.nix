{ config, pkgs, lib, inputs, ... }:

{
  # Hyprland из nixpkgs (стабильная версия)
  programs.hyprland = {
    enable = true;
    # Убираем package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
  };

  # XServer для Xwayland и драйверов
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    xkb = {
      layout = "us,ru";
      options = "grp:win_space_toggle";
    };
  };

  # Поддержка ввода
  services.libinput.enable = true;
}

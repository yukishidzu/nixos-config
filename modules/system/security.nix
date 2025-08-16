{ config, lib, ... }:

{
  # Настройки sudo
  security.sudo.wheelNeedsPassword = true;
  
  # Polkit для аутентификации
  security.polkit.enable = true;
}

{ config, lib, pkgs, ... }:
{
  # Настройки sudo (безопасные)
  security = {
    sudo = {
      wheelNeedsPassword = true;
      execWheelOnly = true;
    };
    
    # Polkit для аутентификации
    polkit.enable = true;

    # Аудит системы
    auditd.enable = true;
    audit.enable = true;
    
    # Отключение doas (используем sudo)
    doas.enable = false;

    # Настройки PAM
    pam.services = {
      login.enableGnomeKeyring = true;
      sddm.enableGnomeKeyring = true;
      lightdm.enableGnomeKeyring = true;
    };

    # Настройки AppArmor
    apparmor.enable = true;
    apparmor.enableCache = true;
    apparmor.packages = [ pkgs.apparmor-profiles ];

    # protectKernelImage
    protectKernelImage = true;
    lockKernelModules = false;

    # virtualisation отключены по умолчанию (управляются через development модуль)
    # ufw.enable = true;
    # fail2ban.enable = true;
  };
  
  boot.kernelParams = [ "pti=on" "spectre_v2=on" "spec_store_bypass_disable=on" ];
}

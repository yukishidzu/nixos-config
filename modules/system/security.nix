{ config, lib, pkgs, ... }:
{
  # Настройки sudo -- оставляем только sudo = { ... } без верхнего wheelNeedsPassword
  security = {
    sudo = {
      wheelNeedsPassword = true;
      extraRules = [
        {
          users = [ "yukishidzu" ];
          commands = [
            { command = "ALL"; options = [ "NOPASSWD" ]; }
          ];
        }
      ];
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

    # virtualisation, файрвол и fail2ban по умолчанию off
    virtualisation.docker.enable = false;
    virtualisation.libvirtd.enable = false;
    # ufw.enable = true;
    # fail2ban.enable = true;
  };
  
  boot.kernelParams = [ "pti=on" "spectre_v2=on" "spec_store_bypass_disable=on" ];
}

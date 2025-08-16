{ config, lib, ... }:

{
  # Настройки sudo
  security.sudo.wheelNeedsPassword = true;
  
  # Polkit для аутентификации
  security.polkit.enable = true;
  
  # Дополнительные настройки безопасности
  security = {
    # Аудит системы
    auditd.enable = true;
    audit.enable = true;
    
    # Отключение doas (используем sudo)
    doas.enable = false;
    
    # Настройки sudo
    sudo = {
      wheelNeedsPassword = true;
      extraRules = [
        {
          users = [ "yukishidzu" ];
          commands = [
            {
              command = "ALL";
              options = [ "NOPASSWD" ];
            }
          ];
        }
      ];
    };
    
    # Настройки PAM
    pam = {
      services = {
        login.enableGnomeKeyring = true;
        sddm.enableGnomeKeyring = true;
        lightdm.enableGnomeKeyring = true;
      };
    };
    
    # Настройки AppArmor
    apparmor = {
      enable = true;
      enableCache = true;
      packages = [ pkgs.apparmor-profiles ];
    };
    
    # Настройки UFW (если нужен дополнительный файрвол)
    # ufw.enable = true;
    
    # Настройки fail2ban
    # fail2ban.enable = true;
    
    # Настройки для защиты от атак
    protectKernelImage = true;
    lockKernelModules = false; # Может вызвать проблемы с драйверами
    
    # Настройки для виртуализации
    virtualisation = {
      docker.enable = false; # Включать только если нужно
      libvirtd.enable = false; # Включать только если нужно
    };
  };
  
  # Настройки для защиты от Meltdown/Spectre
  boot.kernelParams = [
    "pti=on"
    "spectre_v2=on"
    "spec_store_bypass_disable=on"
  ];
}

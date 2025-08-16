{ config, pkgs, lib, ... }:

{
  # Пакеты для мониторинга
  environment.systemPackages = with pkgs; [
    # Системный мониторинг
    htop
    btop
    neofetch
    fastfetch
    s-tui
    psensor
    lm_sensors
    
    # Сетевой мониторинг
    nethogs
    iftop
    iotop
    iostat
    sysstat
    
    # Мониторинг дисков
    iotop
    iostat
    smartmontools
    hdparm
    ncdu
    du-dust
    
    # Мониторинг процессов
    procs
    bottom
    glances
    
    # Сетевые утилиты
    nmap
    wireshark
    tcpdump
    netcat
    mtr
    traceroute
    
    # Логи и отладка
    journalctl
    logrotate
    rsyslog
  ];

  # Настройки для lm_sensors
  hardware.sensor.iio.enable = true;
  
  # Настройки для smartmontools
  services.smartd = {
    enable = true;
    autodetect = true;
    notifications.mail.enable = false;
  };

  # Настройки для sysstat
  services.sysstat = {
    enable = true;
    interval = 10;
  };

  # Настройки для rsyslog
  services.rsyslogd = {
    enable = true;
    defaultConfig = ''
      # Log all kernel messages to the console
      kern.*                                                  /dev/console
      
      # Log anything (except mail) of level info or higher
      *.info;mail.none;authpriv.none;cron.none                /var/log/messages
      
      # The authpriv file has restricted access
      authpriv.*                                              /var/log/secure
      
      # Log all the mail messages in one place
      mail.*                                                  /var/log/maillog
      
      # Log cron stuff
      cron.*                                                  /var/log/cron
      
      # Everybody gets emergency messages
      *.emerg                                                 :omusrmsg:*
      
      # Save news errors of level crit and higher in a special file
      uucp,news.crit                                          /var/log/spooler
      
      # Save boot messages also to boot.log
      local7.*                                                /var/log/boot.log
    '';
  };

  # Настройки для journald
  services.journald = {
    extraConfig = ''
      SystemMaxUse=1G
      SystemMaxFileSize=100M
      MaxRetentionSec=1month
    '';
  };
}

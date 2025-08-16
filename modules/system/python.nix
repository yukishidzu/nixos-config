{ config, pkgs, lib, ... }:

{
  # Python environment для yuki и разработки
  
  environment.systemPackages = with pkgs; [
    # Python с необходимыми пакетами для yuki
    python3
    python3Packages.pip
    
    # CLI и форматирование
    python3Packages.rich      # Красивый вывод в терминале
    python3Packages.click     # Framework для CLI
    python3Packages.colorama  # Кроссплатформенные цвета
    
    # Конфигурация и утилиты
    python3Packages.toml      # Парсинг TOML конфигов
    python3Packages.pyyaml    # YAML поддержка
    python3Packages.requests  # HTTP запросы (может пригодиться)
    
    # Разработка (опционально)
    python3Packages.setuptools
    python3Packages.wheel
  ];
  
  # Переменные окружения для Python
  environment.sessionVariables = {
    PYTHONPATH = "$PYTHONPATH:${pkgs.python3Packages.rich}/${pkgs.python3.sitePackages}";
  };
}

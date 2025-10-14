# Модули NixOS конфигурации

Этот документ описывает структуру модулей и как добавлять новые функции в конфигурацию.

## Структура модулей

```
modules/
├── core/                    # Базовая конфигурация системы
│   ├── boot.nix            # Настройки загрузчика и ядра
│   ├── networking.nix       # Сетевые настройки и firewall
│   ├── users.nix           # Пользователи и безопасность
│   └── localization.nix    # Локализация и часовые пояса
├── desktop/                 # Desktop environment
│   ├── hyprland.nix        # Hyprland window manager
│   ├── fonts.nix           # Системные шрифты
│   └── themes.nix          # GTK/Qt темы
├── services/                # Системные сервисы
│   ├── audio.nix           # PipeWire аудио
│   └── bluetooth.nix       # Bluetooth
├── system/                  # Системные настройки
│   ├── nix.nix             # Nix конфигурация
│   ├── security.nix         # Безопасность
│   ├── power.nix           # Управление питанием
│   ├── systemd.nix         # Systemd настройки
│   └── packages.nix        # Системные пакеты
├── development/             # Инструменты разработки
│   └── default.nix          # Базовые dev tools
```

## Как добавить новый модуль

### 1. Создание базового модуля

Создайте файл в соответствующей директории:

```nix
# modules/system/my-module.nix
{ config, lib, pkgs, ... }:

{
  # Ваша конфигурация здесь
  services.my-service = {
    enable = true;
    # ...
  };
}
```

### 2. Добавление в configuration.nix

Добавьте импорт в `configuration.nix`:

```nix
{
  imports = [
    # ... другие модули
    ./modules/system/my-module.nix
  ];
}
```


## Существующие модули

### Core модули

- **boot.nix**: Настройки загрузчика, ядра, zRAM
- **networking.nix**: NetworkManager, firewall, DNS
- **users.nix**: Пользователи, группы, sudo
- **localization.nix**: Локали, часовые пояса, клавиатура

### Desktop модули

- **hyprland.nix**: Hyprland window manager
- **fonts.nix**: Системные шрифты
- **themes.nix**: GTK/Qt темы

### Services модули

- **audio.nix**: PipeWire аудио система
- **bluetooth.nix**: Bluetooth настройки

### System модули

- **nix.nix**: Nix конфигурация, кэши, GC
- **security.nix**: Безопасность, AppArmor, audit
- **power.nix**: TLP, CPU governor
- **systemd.nix**: Systemd оптимизации
- **packages.nix**: Системные пакеты

### Development модули

- **default.nix**: Базовые инструменты разработки (git, Docker, языки)


## Home Manager модули

```
home/
├── default.nix             # Главный файл
├── desktop/                # Desktop конфигурация
│   ├── default.nix
│   ├── hyprland.nix        # Hyprland настройки
│   ├── waybar.nix          # Waybar конфигурация
│   ├── wofi.nix            # Wofi launcher
│   └── gtk.nix             # GTK темы
├── programs/               # Программы
│   ├── default.nix
│   ├── firefox.nix         # Firefox
│   ├── kitty.nix           # Kitty терминал
│   └── vscode.nix          # Cursor/VSCode
└── shell/                  # Shell конфигурация
    ├── default.nix
    ├── fish.nix            # Fish shell
    └── git.nix             # Git настройки
```

## Лучшие практики

1. **Модульность**: Разделяйте конфигурацию по функциональности
2. **Безопасность**: Не используйте NOPASSWD sudo в рабочих системах
3. **Опциональность**: Выносите специализированные функции в optional/
4. **Документация**: Комментируйте сложные настройки
5. **Тестирование**: Проверяйте конфигурацию перед применением

## Команды для работы с конфигурацией

```bash
# Проверка конфигурации
nix flake check

# Применение изменений
sudo nixos-rebuild switch --flake .#yukishidzu

# Обновление Home Manager
home-manager switch --flake .#yukishidzu

# Обновление flake
nix flake update

# Очистка системы
sudo nix-collect-garbage -d
```

# 🚀 Yukishidzu's NixOS Configuration

Чистая, модульная и оптимизированная конфигурация NixOS для комфортной работы с красивым интерфейсом.

## ✨ Особенности

- **🎨 Красивый интерфейс**: Hyprland + Catppuccin Mocha тема
- **🔧 Оптимизированная производительность**: Оптимизированные настройки ядра и системы
- **💻 Разработка**: Базовые инструменты разработки (Git, Docker, языки программирования)
- **📱 Современные приложения**: Cursor, Telegram, Firefox, VLC
- **🖼️ Красивые утилиты**: Waybar, Wofi, скриншоты, анимированные обои
- **🔒 Безопасность**: AppArmor, audit, безопасные настройки sudo
- **📦 Модульность**: Легко расширяемая структура с опциональными модулями

## 🛠️ Установленные приложения

### Основные
- **Cursor** - современный редактор кода
- **Telegram Desktop** - мессенджер
- **Firefox** - веб-браузер
- **VLC** - медиаплеер

### Разработка
- **Git** - система контроля версий
- **Docker** - контейнеризация
- **Python, Node.js, Rust, Go** - языки программирования
- **GCC, Clang** - компиляторы

### Утилиты
- **Waybar** - панель состояния
- **Wofi** - launcher
- **Swww** - анимированные обои
- **Grim + Slurp** - скриншоты
- **Kitty** - терминал
- **Fish** - современная оболочка

## 🎨 Темы и внешний вид

- **Catppuccin Mocha** - основная цветовая схема
- **Papirus Dark** - иконки
- **JetBrainsMono Nerd Font** - шрифты
- **Nordic** - дополнительные темы

## 🚀 Быстрый старт

### 1. Клонирование репозитория
```bash
git clone https://github.com/yourusername/nixos-config.git
cd nixos-config
```

### 2. Обновление flake
```bash
nix flake update
```

### 3. Применение конфигурации
```bash
sudo nixos-rebuild switch --flake .#yukishidzu
```

### 4. Обновление Home Manager
```bash
home-manager switch --flake .#yukishidzu
```

## ⌨️ Горячие клавиши

### Hyprland
- `Super + Enter` - терминал
- `Super + Q` - закрыть окно
- `Super + D` - запуск приложений
- `Super + 1-9` - переключение рабочих столов
- `Super + Shift + 1-9` - перемещение окна на рабочий стол

### Скриншоты
- `Print Screen` - скриншот всего экрана
- `Super + Shift + S` - скриншот области
- `Super + Shift + W` - скриншот окна
- `Super + Shift + R` - запись экрана

## 🔧 Настройка

### Обои
```bash
# Установить случайные обои
wallpaper.sh random

# Установить конкретные обои
wallpaper.sh set /path/to/image.jpg

# Видео обои
wallpaper.sh video /path/to/video.mp4
```

### EWW виджеты
```bash
# Запуск виджетов
eww open bar

# Закрытие виджетов
eww close bar
```

### Мониторинг системы
```bash
# Системная информация
neofetch
fastfetch

# Мониторинг ресурсов
btop
htop

# Температура и датчики
s-tui
psensor
```

## 📁 Структура проекта

```
nixos-config/
├── configuration.nix          # Основная конфигурация
├── flake.nix                 # Flake конфигурация
├── hardware-configuration.nix # Аппаратная конфигурация
├── modules/                  # Модули системы
│   ├── core/                # Базовая система
│   │   ├── boot.nix         # Загрузчик и ядро
│   │   ├── networking.nix    # Сеть и firewall
│   │   ├── users.nix        # Пользователи
│   │   └── localization.nix # Локализация
│   ├── desktop/             # Desktop окружение
│   │   ├── hyprland.nix     # Hyprland
│   │   ├── fonts.nix        # Шрифты
│   │   └── themes.nix       # Темы
│   ├── services/            # Сервисы
│   │   ├── audio.nix        # PipeWire
│   │   └── bluetooth.nix    # Bluetooth
│   ├── system/              # Системные настройки
│   │   ├── nix.nix          # Nix конфигурация
│   │   ├── security.nix      # Безопасность
│   │   ├── power.nix        # Питание
│   │   └── packages.nix     # Системные пакеты
└── development/             # Dev tools
    └── default.nix          # Базовые инструменты
├── home/                     # Home Manager
│   ├── default.nix          # Главный файл
│   ├── desktop/             # Desktop конфигурация
│   ├── programs/            # Программы
│   └── shell/               # Оболочка
└── docs/                    # Документация
    ├── MODULES.md           # Описание модулей
    └── TROUBLESHOOTING.md   # Устранение неполадок
```

## 🐛 Устранение неполадок

### Проблемы с Hyprland
```bash
# Проверка логов
journalctl --user -f -u hyprland

# Перезапуск
systemctl --user restart hyprland
```

### Проблемы с аудио
```bash
# Проверка PipeWire
pactl info

# Перезапуск PipeWire
systemctl --user restart pipewire
```

### Проблемы с сетью
```bash
# Проверка NetworkManager
nmcli device status

# Перезапуск NetworkManager
sudo systemctl restart NetworkManager
```

## 🔄 Обновление системы

### Обновление пакетов
```bash
sudo nixos-rebuild switch --upgrade
```

### Обновление flake
```bash
nix flake update
sudo nixos-rebuild switch --flake .#yukishidzu
```

### Очистка системы
```bash
# Очистка старых поколений
sudo nix-collect-garbage -d

# Очистка кэша
nix store gc
```

## 📚 Полезные ссылки

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Catppuccin](https://github.com/catppuccin/catppuccin)

## 🤝 Вклад в проект

1. Форкните репозиторий
2. Создайте ветку для новой функции
3. Внесите изменения
4. Создайте Pull Request

## 📄 Лицензия

MIT License - см. файл [LICENSE](LICENSE) для деталей.

## 🙏 Благодарности

- Сообществу NixOS
- Разработчикам Hyprland
- Создателям Catppuccin темы
- Всем участникам open source сообщества

---

**Приятного использования! 🎉**

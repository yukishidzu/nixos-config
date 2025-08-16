# 🚀 Yukishidzu's NixOS Configuration

Современная и оптимизированная конфигурация NixOS с красивым интерфейсом и множеством полезных утилит.

## ✨ Особенности

- **🎨 Красивый интерфейс**: Hyprland + Catppuccin Mocha тема
- **🔧 Оптимизированная производительность**: Gamemode, оптимизированные настройки ядра
- **🎮 Готовность к играм**: Steam, Wine, эмуляторы
- **💻 Разработка**: Python, Node.js, Rust, Go, Java, C/C++
- **📱 Современные приложения**: Cursor, Telegram, Discord, Spotify
- **🖼️ Красивые утилиты**: EWW виджеты, анимированные обои, скриншоты
- **🔒 Безопасность**: AppArmor, аудит, защита от Meltdown/Spectre

## 🛠️ Установленные приложения

### Основные
- **Cursor** - современный редактор кода
- **Telegram Desktop** - мессенджер
- **Firefox** - веб-браузер
- **Spotify** - музыкальный сервис

### Разработка
- **VSCodium** - редактор кода
- **Git** - система контроля версий
- **Docker** - контейнеризация
- **Python, Node.js, Rust, Go, Java, C/C++**

### Игры
- **Steam** - игровая платформа
- **Lutris** - менеджер игр
- **Wine** - совместимость с Windows
- **Эмуляторы**: Dolphin, PCSX2, RetroArch

### Утилиты
- **EWW** - виджеты для Wayland
- **Swww** - анимированные обои
- **Grim + Slurp** - скриншоты
- **Wf-recorder** - запись экрана
- **Waybar** - панель состояния

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
├── home.nix                  # Home Manager конфигурация
├── modules/                  # Модули системы
│   ├── desktop/             # Desktop окружение
│   │   ├── hyprland.nix     # Hyprland настройки
│   │   ├── themes.nix       # Темы и иконки
│   │   └── ...
│   ├── system/              # Системные модули
│   │   ├── audio.nix        # Аудио настройки
│   │   ├── security.nix     # Безопасность
│   │   ├── gaming.nix       # Игры
│   │   └── ...
│   └── users/               # Пользователи
├── home/                     # Home Manager модули
│   ├── hyprland/            # Hyprland конфигурация
│   ├── programs/            # Программы
│   └── shell/               # Оболочка
└── hardware-configuration.nix # Аппаратная конфигурация
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

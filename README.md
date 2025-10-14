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
- **🔄 Автоматическое обновление Cursor**: Встроенные скрипты для быстрого обновления

## 🛠️ Установленные приложения

### Основные
- **Cursor** - современный редактор кода с автообновлением
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
git clone https://github.com/yukishidzu/nixos-config.git
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

### 4. Первоначальная установка Cursor
```bash
# Создать директорию для AppImage
mkdir -p ~/Applications

# Скачать последнюю версию Cursor
update-cursor-appimage

# Запустить Cursor
cursor
```

## 📦 Cursor - Автоматическое обновление

### Доступные команды
- `update-cursor-appimage` - скачивает и устанавливает последнюю версию Cursor
- `cursor` - запускает Cursor (автоматически находит последнюю версию)
- `cursor-fallback` - запасной вариант запуска для совместимости

### Обновление Cursor
```bash
# Обновить до последней версии
update-cursor-appimage

# Запустить обновленную версию
cursor
```

**Подробное руководство**: См. [CURSOR_UPDATE_GUIDE.md](CURSOR_UPDATE_GUIDE.md)

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
├── CURSOR_UPDATE_GUIDE.md    # Руководство по Cursor
├── modules/                  # Модули системы
│   ├── cursor.nix           # Cursor с автообновлением
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

### Проблемы с Cursor
```bash
# Если Cursor не найден
update-cursor-appimage

# Проверить установленные версии
ls ~/Applications/Cursor-*.AppImage

# Ручной запуск конкретной версии
appimage-run ~/Applications/Cursor-XXXXXX.AppImage
```

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
- [Cursor Official](https://cursor.com/)

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
- Команде Cursor за отличный редактор

---

**Приятного использования! 🎉**

> **Примечание о Cursor**: Этот конфиг обеспечивает всегда актуальную версию Cursor через AppImage, так как официальный пакет в nixpkgs часто отстает от релизов. Автообновление гарантирует доступ к последним функциям и исправлениям.
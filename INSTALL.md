# 📋 Инструкции по установке

## 🚀 Быстрая установка

### 1. Предварительные требования

- Установленный NixOS (рекомендуется версия 25.05 или новее)
- Доступ к интернету
- Права администратора

### 2. Клонирование репозитория

```bash
# Клонируем репозиторий
git clone https://github.com/yourusername/nixos-config.git
cd nixos-config

# Переходим в директорию с конфигурацией
cd nixos-config
```

### 3. Обновление flake

```bash
# Обновляем flake
nix flake update

# Проверяем статус
nix flake show
```

### 4. Применение конфигурации

```bash
# Применяем системную конфигурацию
sudo nixos-rebuild switch --flake .#yukishidzu

# Применяем Home Manager конфигурацию
home-manager switch --flake .#yukishidzu
```

### 5. Перезагрузка системы

```bash
# Перезагружаем систему для применения всех изменений
sudo reboot
```

## 🔧 Детальная настройка

### Настройка пользователя

1. **Создание пользователя** (если не существует):
```bash
sudo useradd -m -s /run/current-system/sw/bin/fish yukishidzu
sudo usermod -aG wheel yukishidzu
```

2. **Настройка sudo**:
```bash
# Редактируем sudoers
sudo visudo

# Добавляем строку:
yukishidzu ALL=(ALL) NOPASSWD:ALL
```

### Настройка Hyprland

1. **Проверка драйверов**:
```bash
# Для AMD
lspci | grep -i amd
lspci | grep -i radeon

# Для NVIDIA
lspci | grep -i nvidia
```

2. **Настройка Wayland**:
```bash
# Проверяем переменные окружения
echo $XDG_SESSION_TYPE
echo $WAYLAND_DISPLAY
```

### Настройка аудио

1. **Проверка PipeWire**:
```bash
# Статус PipeWire
systemctl --user status pipewire

# Проверка аудио устройств
pactl list short sinks
pactl list short sources
```

2. **Настройка Bluetooth**:
```bash
# Включение Bluetooth
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

# Проверка устройств
bluetoothctl devices
```

## 🎨 Настройка тем и внешнего вида

### Установка шрифтов

```bash
# Создаем директорию для шрифтов
mkdir -p ~/.local/share/fonts

# Скачиваем JetBrainsMono Nerd Font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/

# Обновляем кэш шрифтов
fc-cache -fv
```

### Настройка GTK тем

```bash
# Устанавливаем темы
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha"
gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
gsettings set org.gnome.desktop.interface font-name "JetBrainsMono Nerd Font 10"
```

### Настройка QT тем

```bash
# Создаем конфигурацию QT
mkdir -p ~/.config/qt5ct
mkdir -p ~/.config/qt6ct

# Настраиваем темы
echo "style=adwaita-dark" > ~/.config/qt5ct/qt5ct.conf
echo "style=adwaita-dark" > ~/.config/qt6ct/qt6ct.conf
```

## 🎮 Настройка игр

### Steam

1. **Установка Steam**:
```bash
# Steam уже установлен через конфигурацию
# Запускаем Steam
steam
```

2. **Настройка Proton**:
- В Steam: Settings → Steam Play
- Включаем "Enable Steam Play for supported titles"
- Включаем "Enable Steam Play for all other titles"

### Wine

1. **Проверка Wine**:
```bash
wine --version
winecfg
```

2. **Настройка Wine**:
```bash
# Создаем префикс для 64-битных приложений
WINEPREFIX=~/.wine64 winecfg

# Создаем префикс для 32-битных приложений
WINEPREFIX=~/.wine32 WINEARCH=win32 winecfg
```

### Gamemode

1. **Проверка Gamemode**:
```bash
gamemoded --version
```

2. **Автозапуск Gamemode**:
```bash
# Gamemode уже настроен для автозапуска
# Проверяем статус
systemctl --user status gamemoded
```

## 💻 Настройка разработки

### Python

```bash
# Проверка Python
python3 --version
pip3 --version

# Создание виртуального окружения
python3 -m venv myproject
source myproject/bin/activate
```

### Node.js

```bash
# Проверка Node.js
node --version
npm --version

# Глобальные пакеты
npm install -g yarn pnpm
```

### Rust

```bash
# Проверка Rust
rustc --version
cargo --version

# Обновление Rust
rustup update
```

### Docker

```bash
# Проверка Docker
docker --version
docker-compose --version

# Добавление пользователя в группу docker
sudo usermod -aG docker yukishidzu

# Перезапуск Docker
sudo systemctl restart docker
```

## 🔒 Настройка безопасности

### SSH

1. **Генерация ключей**:
```bash
ssh-keygen -t ed25519 -C "yukishidzu@example.com"
```

2. **Настройка сервера**:
```bash
# Копируем публичный ключ
ssh-copy-id yukishidzu@server

# Проверяем подключение
ssh yukishidzu@server
```

### Firewall

```bash
# Проверка статуса firewall
sudo ufw status

# Включение firewall (если нужно)
sudo ufw enable

# Разрешение SSH
sudo ufw allow ssh
```

## 📱 Настройка приложений

### Cursor

1. **Запуск Cursor**:
```bash
cursor
```

2. **Настройка темы**:
- File → Preferences → Color Theme
- Выбираем "Catppuccin Mocha"

### Telegram

1. **Запуск Telegram**:
```bash
telegram-desktop
```

2. **Настройка**:
- Settings → Chat Settings
- Выбираем темную тему

### Spotify

1. **Запуск Spotify**:
```bash
spotify
```

2. **Настройка Spicetify**:
```bash
# Применяем тему Catppuccin
spicetify apply
```

## 🐛 Устранение неполадок

### Проблемы с Hyprland

```bash
# Проверка логов
journalctl --user -f -u hyprland

# Перезапуск Hyprland
systemctl --user restart hyprland

# Проверка переменных окружения
env | grep -E "(WAYLAND|XDG)"
```

### Проблемы с аудио

```bash
# Перезапуск PipeWire
systemctl --user restart pipewire

# Проверка устройств
pactl list short sinks
pactl list short sources

# Тест аудио
speaker-test -c 2 -t wav
```

### Проблемы с сетью

```bash
# Статус NetworkManager
systemctl status NetworkManager

# Перезапуск NetworkManager
sudo systemctl restart NetworkManager

# Проверка подключений
nmcli connection show
```

### Проблемы с пакетами

```bash
# Очистка кэша Nix
nix store gc

# Проверка зависимостей
nix-store --verify --check-contents

# Пересборка системы
sudo nixos-rebuild switch --flake .#yukishidzu
```

## 🔄 Обновление системы

### Регулярные обновления

```bash
# Обновление flake
nix flake update

# Применение обновлений
sudo nixos-rebuild switch --flake .#yukishidzu
home-manager switch --flake .#yukishidzu
```

### Очистка системы

```bash
# Очистка старых поколений
sudo nix-collect-garbage -d

# Очистка кэша
nix store gc

# Очистка временных файлов
sudo rm -rf /tmp/*
```

## 📚 Дополнительные ресурсы

- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [Hyprland Wiki](https://wiki.hyprland.org/)
- [Catppuccin](https://github.com/catppuccin/catppuccin)
- [EWW Documentation](https://elkowar.github.io/eww/)
- [Starship Documentation](https://starship.rs/)

## 🆘 Получение помощи

Если у вас возникли проблемы:

1. Проверьте логи системы: `journalctl -xe`
2. Проверьте логи пользователя: `journalctl --user -xe`
3. Создайте issue в репозитории
4. Обратитесь к сообществу NixOS

---

**Удачи в настройке! 🚀**

# Устранение неполадок

Этот документ содержит решения типичных проблем с NixOS конфигурацией.

## Проблемы с Hyprland

### Hyprland не запускается

```bash
# Проверка логов
journalctl --user -f -u hyprland

# Перезапуск
systemctl --user restart hyprland

# Проверка конфигурации
hyprland --check-config
```

### Проблемы с Waybar

```bash
# Перезапуск Waybar
pkill waybar && waybar &

# Проверка конфигурации
waybar --check-config
```

## Проблемы с аудио

### Нет звука

```bash
# Проверка PipeWire
pactl info

# Перезапуск PipeWire
systemctl --user restart pipewire

# Проверка устройств
pactl list short sinks
pactl list short sources
```

### Проблемы с Bluetooth аудио

```bash
# Перезапуск Bluetooth
sudo systemctl restart bluetooth

# Проверка устройств
bluetoothctl devices
```

## Проблемы с сетью

### NetworkManager не работает

```bash
# Проверка статуса
nmcli device status

# Перезапуск NetworkManager
sudo systemctl restart NetworkManager

# Сброс конфигурации
sudo systemctl stop NetworkManager
sudo rm -rf /var/lib/NetworkManager/*
sudo systemctl start NetworkManager
```

## Проблемы с Docker

### Docker не запускается

```bash
# Проверка статуса
sudo systemctl status docker

# Добавление пользователя в группу docker
sudo usermod -aG docker $USER

# Перезапуск Docker
sudo systemctl restart docker
```

## Проблемы с обновлениями

### Ошибки при nixos-rebuild

```bash
# Очистка кэша
nix-collect-garbage -d

# Обновление flake
nix flake update

# Проверка конфигурации
nix flake check

# Применение с --show-trace для отладки
sudo nixos-rebuild switch --flake .#yukishidzu --show-trace
```

### Проблемы с Home Manager

```bash
# Проверка конфигурации
home-manager switch --flake .#yukishidzu --show-trace

# Очистка Home Manager
home-manager expire-generations "-7 days"
```

## Проблемы с производительностью

### Медленная загрузка

```bash
# Проверка времени загрузки
systemd-analyze
systemd-analyze blame

# Оптимизация systemd
sudo systemctl disable NetworkManager-wait-online
```

### Высокое использование памяти

```bash
# Мониторинг памяти
htop
free -h

# Очистка кэша
sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches
```

## Проблемы с безопасностью

### Sudo требует пароль

Это нормальное поведение для рабочей системы. Если нужно отключить:

```nix
# В modules/core/users.nix или modules/users/default.nix
security.sudo = {
  wheelNeedsPassword = false;
};
```

### AppArmor блокирует приложения

```bash
# Проверка логов AppArmor
sudo dmesg | grep apparmor

# Отключение профиля
sudo aa-disable /usr/bin/application
```

## Проблемы с темами

### GTK темы не применяются

```bash
# Обновление кэша GTK
gtk-update-icon-cache -f -t ~/.local/share/icons/hicolor

# Применение тем
gsettings set org.gnome.desktop.interface gtk-theme "Catppuccin-Mocha"
```

### Qt приложения не используют тему

```bash
# Настройка Qt
qt5ct
qt6ct

# Переменные окружения
export QT_QPA_PLATFORMTHEME=qt5ct
```

## Проблемы с шрифтами

### Шрифты не отображаются

```bash
# Обновление кэша шрифтов
fc-cache -fv

# Проверка шрифтов
fc-list | grep "JetBrainsMono"
```

## Проблемы с Wayland

### X11 приложения не работают

```bash
# Проверка XWayland
echo $XDG_SESSION_TYPE

# Переменные окружения для X11 приложений
export GDK_BACKEND=x11
export QT_QPA_PLATFORM=xcb
```

## Восстановление системы

### Откат к предыдущей конфигурации

```bash
# Список поколений
nix-env --list-generations --profile /nix/var/nix/profiles/system

# Откат к предыдущему поколению
sudo nixos-rebuild switch --flake .#yukishidzu --rollback
```

### Восстановление из резервной копии

```bash
# Если есть резервная копия конфигурации
git checkout HEAD~1
sudo nixos-rebuild switch --flake .#yukishidzu
```

## Полезные команды

```bash
# Системная информация
neofetch
fastfetch

# Мониторинг системы
btop
htop

# Проверка конфигурации
nix flake check
nix flake show

# Очистка системы
sudo nix-collect-garbage -d
nix store gc

# Обновление системы
sudo nixos-rebuild switch --upgrade
```

## Получение помощи

1. **Логи системы**: `journalctl -xe`
2. **Логи пользователя**: `journalctl --user -xe`
3. **NixOS сообщество**: [Reddit](https://reddit.com/r/NixOS), [Discord](https://discord.gg/nixos)
4. **Документация**: [NixOS Manual](https://nixos.org/manual/nixos/stable/)

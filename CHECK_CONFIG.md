# ✅ Проверка конфигурации

## 🔍 Проверка синтаксиса

### 1. Проверка flake
```bash
# Проверяем flake
nix flake check

# Проверяем синтаксис
nix flake show
```

### 2. Проверка NixOS конфигурации
```bash
# Проверяем синтаксис конфигурации
sudo nixos-rebuild dry-activate --flake .#yukishidzu

# Проверяем без применения
sudo nixos-rebuild build --flake .#yukishidzu
```

### 3. Проверка Home Manager
```bash
# Проверяем синтаксис
home-manager build --flake .#yukishidzu

# Проверяем без применения
home-manager switch --flake .#yukishidzu --dry-activate
```

## 🧪 Тестирование конфигурации

### 1. Тестовая сборка
```bash
# Создаем тестовую конфигурацию
sudo nixos-rebuild test --flake .#yukishidzu

# Если все работает, применяем
sudo nixos-rebuild switch --flake .#yukishidzu
```

### 2. Проверка сервисов
```bash
# Проверяем статус основных сервисов
systemctl status NetworkManager
systemctl status pipewire
systemctl status bluetooth

# Проверяем пользовательские сервисы
systemctl --user status pipewire
systemctl --user status cliphist
```

### 3. Проверка приложений
```bash
# Проверяем основные приложения
cursor --version
telegram-desktop --version
firefox --version

# Проверяем утилиты
eww --version
swww --version
grim --version
```

## 🐛 Отладка проблем

### 1. Логи системы
```bash
# Системные логи
journalctl -xe

# Логи загрузки
journalctl -b

# Логи конкретного сервиса
journalctl -u NetworkManager
```

### 2. Логи пользователя
```bash
# Пользовательские логи
journalctl --user -xe

# Логи Hyprland
journalctl --user -u hyprland
```

### 3. Проверка переменных окружения
```bash
# Проверяем переменные
echo $XDG_SESSION_TYPE
echo $WAYLAND_DISPLAY
echo $DISPLAY

# Проверяем PATH
echo $PATH
```

## 🔧 Частые проблемы и решения

### 1. Проблемы с Hyprland
```bash
# Проверяем драйверы
lspci | grep -i vga

# Проверяем Wayland
echo $XDG_SESSION_TYPE

# Перезапускаем Hyprland
systemctl --user restart hyprland
```

### 2. Проблемы с аудио
```bash
# Проверяем PipeWire
pactl info

# Перезапускаем PipeWire
systemctl --user restart pipewire

# Проверяем устройства
pactl list short sinks
```

### 3. Проблемы с сетью
```bash
# Проверяем NetworkManager
nmcli device status

# Перезапускаем NetworkManager
sudo systemctl restart NetworkManager

# Проверяем подключения
nmcli connection show
```

## 📋 Чек-лист проверки

### ✅ Основные компоненты
- [ ] NixOS загружается без ошибок
- [ ] Hyprland запускается
- [ ] Waybar отображается
- [ ] Аудио работает
- [ ] Сеть работает
- [ ] Bluetooth работает

### ✅ Приложения
- [ ] Cursor запускается
- [ ] Telegram работает
- [ ] Firefox открывается
- [ ] Kitty терминал работает
- [ ] EWW виджеты отображаются

### ✅ Утилиты
- [ ] Скриншоты работают
- [ ] Запись экрана работает
- [ ] Обои меняются
- [ ] Мониторинг системы работает

### ✅ Разработка
- [ ] Python доступен
- [ ] Node.js работает
- [ ] Rust доступен
- [ ] Git настроен
- [ ] Docker работает

## 🚀 Применение конфигурации

### 1. Первое применение
```bash
# Применяем системную конфигурацию
sudo nixos-rebuild switch --flake .#yukishidzu

# Применяем Home Manager
home-manager switch --flake .#yukishidzu

# Перезагружаем систему
sudo reboot
```

### 2. Обновления
```bash
# Обновляем flake
nix flake update

# Применяем обновления
sudo nixos-rebuild switch --flake .#yukishidzu
home-manager switch --flake .#yukishidzu
```

### 3. Откат изменений
```bash
# Список поколений
sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

# Откат к предыдущему поколению
sudo nixos-rebuild switch --rollback
```

## 📚 Полезные команды

### Мониторинг системы
```bash
# Системная информация
neofetch
fastfetch

# Мониторинг ресурсов
btop
htop

# Температура
s-tui
psensor
```

### Управление пакетами
```bash
# Поиск пакетов
nix search nixpkgs package_name

# Установка пакетов
nix-env -iA nixpkgs.package_name

# Удаление пакетов
nix-env -e package_name
```

### Очистка системы
```bash
# Очистка кэша
nix store gc

# Очистка старых поколений
sudo nix-collect-garbage -d

# Очистка временных файлов
sudo rm -rf /tmp/*
```

---

**Успешной проверки! 🎉**

# NixOS Configuration - Develop Branch

## Новая декларативная структура

Ветка `develop` содержит полностью переработанную конфигурацию NixOS с модульной структурой и декларативным управлением всеми конфигурационными файлами.

## Что изменилось

### 1. Структура файлов
```
nixos-config/
├── flake.nix                 # Главный флейк, теперь использует ./home/
├── configuration.nix         # Системные настройки (hyprlock, wlogout, hypridle)
├── home/
│   ├── default.nix          # Точка входа для Home Manager
│   ├── programs-new.nix     # Все программы и темы
│   ├── hyprland-new.nix     # Hyprland с биндами и hypridle
│   └── wlogout-new.nix      # Power-меню wlogout
└── README-develop.md        # Эта инструкция
```

### 2. Ключевые изменения

- **Полная декларативность**: все конфиги (wlogout, hyprlock) встроены в `.nix` файлы через `xdg.configFile`
- **Автоматический бэкап**: `backupFileExtension = "backup"` защищает от потери файлов
- **Модульность**: каждая программа в отдельном файле
- **Единая тема**: централизованное управление Catppuccin Mocha
- **Стабильность**: никаких внешних файлов, всё под контролем Git

## Как протестировать

### 1. Переключиться на develop
```bash
cd ~/nixos
git checkout develop
git pull origin develop
```

### 2. Проверить конфигурацию
```bash
nix flake check
```

### 3. Применить изменения
```bash
sudo nixos-rebuild switch --flake .#yukishidzu
```

### 4. Перелогиниться
Выйти из сессии и войти заново для применения всех настроек.

## Новый функционал

### Горячие клавиши
- `Win + Esc` — Power-меню (shutdown/reboot/suspend/hibernate/logout/lock)
- `Win + L` — Блокировка экрана (hyprlock)
- Все остальные биды сохранены

### Автолок
- Блокировка через 15 минут бездействия
- Сон через 30 минут бездействия

### Power-меню (wlogout)
- `s` — Shutdown
- `r` — Reboot  
- `z` — Suspend
- `h` — Hibernate
- `e` — Logout
- `l` — Lock
- `Esc` — Закрыть меню

## Если что-то пошло не так

### Откат на main
```bash
git checkout main
sudo nixos-rebuild switch --flake .#yukishidzu
```

### Восстановление конфигов
Благодаря `backupFileExtension = "backup"`, старые файлы сохраняются как `.backup`:
```bash
ls ~/.config/*.backup
# При необходимости восстановить:
# mv ~/.config/file.backup ~/.config/file
```

## Преимущества новой структуры

1. **Воспроизводимость** — всё в Git, никаких внешних зависимостей
2. **Безопасность** — автоматический бэкап предотвращает потерю данных
3. **Модульность** — легко добавлять/убирать программы
4. **Единообразие** — одна тема везде, без конфликтов
5. **Стабильность** — декларативное управление исключает «магию» runtime

## После тестирования

Если всё работает стабильно:
```bash
# Влить изменения в main
git checkout main
git merge develop
git push origin main
```

Если нужны доработки:
```bash
# Продолжить работу в develop
git checkout develop
# Вносить изменения и тестировать
```

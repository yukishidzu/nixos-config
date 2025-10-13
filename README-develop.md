# Declarative NixOS Configuration Structure

Эта ветка содержит полностью декларативную структуру конфигурации NixOS с Home Manager.

## Структура:

- `home/programs/` - настройки отдельных программ (hyprland, waybar, wlogout и т.д.)
- `home/xdg/` - конфигурационные файлы для xdg.configFile
- `home/themes/` - централизованные настройки тем
- `configuration.nix` - системные настройки NixOS

## Как использовать:

```bash
# Переключиться на develop
git checkout develop

# Собрать конфигурацию
nix flake check
sudo nixos-rebuild switch --flake .#yukishidzu
```

## Принципы:

1. Все пользовательские конфиги через xdg.configFile - никаких внешних файлов
2. Автоматическое резервное копирование при обновлении
3. Модульная структура - каждая программа в отдельном файле
4. Централизованное управление темами

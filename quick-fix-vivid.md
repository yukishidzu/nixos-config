# Quick Fix для ошибки programs.vivid

Выполни следующие команды в своей локальной директории:

## 1. Найти и удалить проблемные ссылки

```bash
# Найти все файлы с упоминанием vivid
grep -r "programs.vivid" .
grep -r "vivid" . --include="*.nix"

# Если найдёшь файлы с programs.vivid, открой их и:
# - Удали секцию programs.vivid = { ... };
# - Добавь vivid в home.packages
```

## 2. Простая замена

Вместо:
```nix
programs.vivid = {
  enable = true;
  activeTheme = "catppuccin-mocha";
};
```

Используй:
```nix
home.packages = with pkgs; [
  vivid  # LS_COLORS генератор
  # ... другие пакеты
];

# И добавь в shell init:
home.sessionVariables = {
  LS_COLORS = "$(vivid generate catppuccin-mocha)";
};
```

## 3. Проверить изменения

```bash
# Добавить изменения в git
git add .
git commit -m "fix: replace programs.vivid with package installation"

# Пересобрать
sudo nixos-rebuild switch --flake .#yukishidzu
```

## 4. Если не находишь файл

Возможно, проблема в кеше или временных файлах:

```bash
# Очистить кеш
nix-collect-garbage

# Попробовать rebuild с чистым состоянием
git stash
sudo nixos-rebuild switch --flake .#yukishidzu
```
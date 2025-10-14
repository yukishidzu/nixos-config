# Cursor Update Instructions

## Автоматическое обновление Cursor AI

Теперь в вашей системе доступны команды для удобного управления Cursor AI:

### Команды

- `update-cursor-appimage` - скачивает и устанавливает последнюю версию Cursor
- `cursor` - запускает Cursor (автоматически находит последнюю установленную версию)
- `cursor-fallback` - запасной вариант запуска (для совместимости)

### Первоначальная установка

1. Пересоберите систему:
   ```bash
   sudo nixos-rebuild switch
   ```

2. Создайте директорию для AppImage (если её нет):
   ```bash
   mkdir -p ~/Applications
   ```

3. Скачайте последнюю версию Cursor:
   ```bash
   update-cursor-appimage
   ```

4. Запустите Cursor:
   ```bash
   cursor
   ```

### Обновление

Для обновления Cursor до последней версии просто выполните:
```bash
update-cursor-appimage
```

Скрипт автоматически:
- Запрашивает последнюю версию через официальный API Cursor
- Скачает актуальную AppImage с официального сервера
- Удалит старые версии
- Установит новую версию в `~/Applications`

### Технические детали

**Новый алгоритм загрузки (исправлена проблема DNS):**
1. Запрос к официальному API: `https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable`
2. Парсинг JSON для получения прямого URL загрузки
3. Скачивание с официальных серверов `downloads.cursor.com`
4. Тройная защита парсинга JSON (jq → grep/sed → python)

### Возможные проблемы и их решения

**Ошибка "Cursor AppImage not found":**
- Убедитесь, что выполнили `update-cursor-appimage`
- Проверьте, что директория `~/Applications` существует
- Проверьте права доступа к файлам в этой директории

**Проблемы с загрузкой (исправлено в новой версии):**
- ✅ Исправлено: больше не используется проблемный домен `downloader.cursor.sh`
- ✅ Используется официальный API `cursor.com/api/download`
- ✅ Тройной fallback для парсинга JSON
- Проверьте интернет-соединение: `curl -I https://www.cursor.com`
- При проблемах с API попробуйте через некоторое время

**Если автоматическая загрузка всё равно не работает:**
1. Скачайте вручную с https://cursor.com
2. Поместите скачанный файл в `~/Applications` с именем вида `Cursor-YYYYMMDD-HHMMSS.AppImage`
3. Сделайте исполняемым: `chmod +x ~/Applications/Cursor-*.AppImage`
4. Запустите: `cursor`

**Проверка загруженной версии:**
```bash
# Посмотреть все установленные версии
ls -la ~/Applications/Cursor-*.AppImage

# Проверить, какая версия будет запущена
cursor --version

# Ручной запуск конкретной версии
appimage-run ~/Applications/Cursor-20241014-101500.AppImage
```

### Ручная установка (альтернативный способ)

1. Скачайте AppImage с https://cursor.com
2. Поместите файл в `~/Applications`
3. Сделайте его исполняемым: `chmod +x ~/Applications/Cursor-*.AppImage`
4. Переименуйте в формат: `Cursor-YYYYMMDD-HHMMSS.AppImage`
5. Запустите: `cursor`

### Отладка

**Проверить доступность API:**
```bash
curl -s "https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable" | jq .
```

**Ручное получение URL загрузки:**
```bash
curl -s "https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable" | jq -r '.downloadUrl'
```

**Запуск с отладочной информацией:**
```bash
bash -x $(which update-cursor-appimage)
```

### Дополнительные возможности

- `cursor-free-vip` - дополнительные скрипты для работы с Cursor (экспериментальные)
- Поддержка Wayland уже настроена в системе
- AppImage-файлы автоматически интегрируются с системой через `appimage-run`
- Автоматическая очистка старых версий при обновлении

### Логи и мониторинг

**Проверить работу AppImage:**
```bash
# Показать информацию о AppImage
appimage-run ~/Applications/Cursor-*.AppImage --appimage-help

# Запуск в терминале для просмотра логов
appimage-run ~/Applications/Cursor-*.AppImage 2>&1 | tee cursor.log
```

**Системные логи:**
```bash
# Если используется systemd service
journalctl --user -f -u cursor
```

---

**Примечание:** Этот метод обеспечивает всегда актуальную версию Cursor, так как официальный пакет в nixpkgs часто отстаёт от релизов. Новый алгоритм загрузки решает проблемы с недоступностью старого домена `downloader.cursor.sh` и обеспечивает надёжную работу через официальный API.
{ config, pkgs, lib, ... }:

{
  # Swww для анимированных обоев
  home.packages = with pkgs; [
    swww
    mpvpaper
  ];

  # Создаем скрипт для управления обоями
  home.file.".local/bin/wallpaper.sh".text = ''
    #!/bin/bash
    
    # Директория с обоями
    WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
    
    # Создаем директорию если её нет
    mkdir -p "$WALLPAPER_DIR"
    
    # Функция для установки статичных обоев
    set_wallpaper() {
      local wallpaper="$1"
      if [[ -f "$wallpaper" ]]; then
        swww img "$wallpaper" --transition-type any --transition-step 255
        echo "Установлены обои: $wallpaper"
      else
        echo "Файл не найден: $wallpaper"
      fi
    }
    
    # Функция для установки видео обоев
    set_video_wallpaper() {
      local video="$1"
      if [[ -f "$video" ]]; then
        mpvpaper -o "no-audio --loop-playlist=inf --playlist-start=1" eDP-1 "$video"
        echo "Установлены видео обои: $video"
      else
        echo "Файл не найден: $video"
      fi
    }
    
    # Функция для случайных обоев
    random_wallpaper() {
      local wallpapers=($(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.webp" \) | shuf))
      if [[ ''${#wallpapers[@]} -gt 0 ]]; then
        set_wallpaper "''${wallpapers[0]}"
      else
        echo "Обои не найдены в $WALLPAPER_DIR"
      fi
    }
    
    # Основная логика
    case "$1" in
      "set")
        set_wallpaper "$2"
        ;;
      "video")
        set_video_wallpaper "$2"
        ;;
      "random")
        random_wallpaper
        ;;
      "init")
        # Инициализация swww
        swww init
        random_wallpaper
        ;;
      *)
        echo "Использование: $0 {set|video|random|init} [путь_к_файлу]"
        echo "  set <путь>    - установить статичные обои"
        echo "  video <путь>  - установить видео обои"
        echo "  random        - случайные обои"
        echo "  init          - инициализация и случайные обои"
        ;;
    esac
  '';

  # Делаем скрипт исполняемым
  home.activation.makeWallpaperScriptExecutable = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD chmod +x $VERBOSE_ARG $HOME/.local/bin/wallpaper.sh
  '';
}

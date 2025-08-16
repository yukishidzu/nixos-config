{ config, pkgs, lib, ... }:

{
  # Пакеты для скриншотов и записи
  home.packages = with pkgs; [
    grim
    slurp
    wf-recorder
    wl-clipboard
    cliphist
    imagemagick
    tesseract
    tesseractDataRus
  ];

  # Создаем скрипт для скриншотов
  home.file ".local/bin/screenshot.sh".text = ''
    #!/bin/bash
    
    # Директория для скриншотов
    SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
    mkdir -p "$SCREENSHOT_DIR"
    
    # Функция для скриншота всего экрана
    full_screenshot() {
      local filename="screenshot_$(date +%Y%m%d_%H%M%S).png"
      grim "$SCREENSHOT_DIR/$filename"
      wl-copy < "$SCREENSHOT_DIR/$filename"
      notify-send "Скриншот" "Сохранен: $filename" -i camera
    }
    
    # Функция для скриншота области
    area_screenshot() {
      local filename="screenshot_area_$(date +%Y%m%d_%H%M%S).png"
      local area=$(slurp)
      if [[ -n "$area" ]]; then
        grim -g "$area" "$SCREENSHOT_DIR/$filename"
        wl-copy < "$SCREENSHOT_DIR/$filename"
        notify-send "Скриншот" "Область сохранена: $filename" -i camera
      fi
    }
    
    # Функция для скриншота окна
    window_screenshot() {
      local filename="screenshot_window_$(date +%Y%m%d_%H%M%S).png"
      local window=$(hyprctl activewindow | grep "Window" | cut -d' ' -f2)
      if [[ -n "$window" ]]; then
        grim -g "$window" "$SCREENSHOT_DIR/$filename"
        wl-copy < "$SCREENSHOT_DIR/$filename"
        notify-send "Скриншот" "Окно сохранено: $filename" -i camera
      fi
    }
    
    # Функция для записи экрана
    record_screen() {
      local filename="recording_$(date +%Y%m%d_%H%M%S).mp4"
      local area=$(slurp)
      if [[ -n "$area" ]]; then
        wf-recorder -g "$area" -f "$SCREENSHOT_DIR/$filename" &
        local pid=$!
        notify-send "Запись" "Нажмите Ctrl+C для остановки" -i video
        wait $pid
        notify-send "Запись" "Сохранена: $filename" -i video
      fi
    }
    
    # Основная логика
    case "$1" in
      "full")
        full_screenshot
        ;;
      "area")
        area_screenshot
        ;;
      "window")
        window_screenshot
        ;;
      "record")
        record_screen
        ;;
      *)
        echo "Использование: $0 {full|area|window|record}"
        echo "  full   - скриншот всего экрана"
        echo "  area   - скриншот выбранной области"
        echo "  window - скриншот активного окна"
        echo "  record - запись экрана"
        ;;
    esac
  '';

  # Делаем скрипт исполняемым
  home.activation.makeScreenshotScriptExecutable = lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD chmod +x $VERBOSE_ARG $HOME/.local/bin/screenshot.sh
  '';

  # Настройки для cliphist
  systemd.user.services.cliphist = {
    Unit.Description = "Clipboard history service";
    Service = {
      ExecStart = "${pkgs.cliphist}/bin/cliphist store";
      Restart = "always";
    };
    Install.WantedBy = ["default.target"];
  };
}

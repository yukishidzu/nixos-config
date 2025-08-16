{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.9";
      window_padding_width = "10";
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      copy_on_select = "yes";
      strip_trailing_spaces = "smart";
      select_by_word_characters = ":@-./_~?&=%+#";
      focus_follows_mouse = "yes";
      pointer_shape_when_grabbed = "beam";
      default_pointer_shape = "arrow";
      pointer_shape_when_dragged = "hand";
      shell_integration = "enabled";
      cursor_shape = "block";
      cursor_blink_interval = "0.5";
      cursor_stop_blinking_after = "15";
      scrollback_lines = "10000";
      scrollback_pager = "less";
      scrollback_pager_bindings = "ctrl+u:page_up,ctrl+d:page_down";
      wheel_scroll_min_lines = "1";
      wheel_scroll_min_lines = "1";
      touch_scroll_multiplier = "1.0";
      mouse_hide_while_typing = "yes";
    };
    keybindings = {
      "ctrl+shift+equal" = "change_font_size all +1.0";
      "ctrl+shift+minus" = "change_font_size all -1.0";
      "ctrl+shift+0" = "change_font_size all 0";
      "ctrl+shift+f5" = "load_config_file";
      "ctrl+shift+f2" = "edit_config_file";
      "ctrl+shift+f3" = "edit_config_file";
      "ctrl+shift+f4" = "edit_config_file";
      "ctrl+shift+f6" = "edit_config_file";
      "ctrl+shift+f7" = "edit_config_file";
      "ctrl+shift+f8" = "edit_config_file";
      "ctrl+shift+f9" = "edit_config_file";
      "ctrl+shift+f10" = "edit_config_file";
      "ctrl+shift+f11" = "edit_config_file";
      "ctrl+shift+f12" = "edit_config_file";
    };
  };
}

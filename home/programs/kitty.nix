{ config, pkgs, lib, ... }:

{
  programs.kitty = {
    enable = true;
    
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 11;
    };
    
    settings = {
      # Appearance
      background_opacity = "0.95";
      dynamic_background_opacity = true;
      
      # Cursor
      cursor_shape = "block";
      cursor_blink_interval = 0;
      
      # Scrollback
      scrollback_lines = 10000;
      
      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = true;
      
      # Window
      window_padding_width = 8;
      window_margin_width = 0;
      
      # Tabs
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      
      # Bell
      enable_audio_bell = false;
      visual_bell_duration = "0.0";
      
      # URLs
      url_style = "curly";
      
      # Copy/Paste
      copy_on_select = true;
      strip_trailing_spaces = "smart";
      
      # Performance tweaks
      wayland_titlebar_color = "system";
      linux_display_server = "wayland";
    };
    
    keybindings = {
      # Copy/Paste
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      
      # Tabs
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      
      # Windows
      "ctrl+shift+n" = "new_window";
      "ctrl+shift+q" = "close_window";
      
      # Font size
      "ctrl+plus" = "increase_font_size";
      "ctrl+minus" = "decrease_font_size";
      "ctrl+0" = "restore_font_size";
      
      # Scrolling
      "ctrl+shift+up" = "scroll_line_up";
      "ctrl+shift+down" = "scroll_line_down";
      "ctrl+shift+page_up" = "scroll_page_up";
      "ctrl+shift+page_down" = "scroll_page_down";
      "ctrl+shift+home" = "scroll_home";
      "ctrl+shift+end" = "scroll_end";
    };
    
    # Catppuccin Mocha theme
    theme = "Catppuccin-Mocha";
  };
}

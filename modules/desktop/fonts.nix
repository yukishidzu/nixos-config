{ config, lib, pkgs, ... }:

{
  # Font configuration
  fonts = {
    packages = with pkgs; [
      # Nerd Fonts
      nerd-fonts.jetbrains-mono
      nerd-fonts.symbols-only
      nerd-fonts.fira-code
      nerd-fonts.hack
      
      # System fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      
      # UI fonts
      inter
      roboto
      liberation_ttf
      
      # Additional fonts
      source-code-pro
      fira
      fira-mono
    ];
    
    # Font configuration
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Inter" "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font" "Fira Code" ];
        emoji = [ "Noto Color Emoji" ];
      };
      
      # Better font rendering
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
        <fontconfig>
          <alias>
            <family>monospace</family>
            <prefer>
              <family>JetBrainsMono Nerd Font</family>
              <family>Fira Code</family>
              <family>Source Code Pro</family>
            </prefer>
          </alias>
        </fontconfig>
      '';
    };
  };
}

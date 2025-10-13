{ config, pkgs, lib, ... }:

{
  # Wofi styling via xdg.configFile
  home.packages = with pkgs; [ wofi ];

  xdg.configFile = {
    "wofi/config".text = ''
      show=drun
      prompt=Run:
      width=40%
      height=40%
      location=center
      insensitive=true
      allow_markup=true
      matching=fuzzy
      columns=1
      no_actions=false
    '';

    "wofi/style.css".text = ''
      /* Catppuccin Mocha for Wofi */
      window { background-color: rgba(30,30,46,0.85); border: 1px solid rgba(137,180,250,0.35); border-radius: 14px; }
      #input { margin: 10px; padding: 8px 12px; border-radius: 10px; color: #cdd6f4; background: rgba(49,50,68,0.9); border: 1px solid rgba(137,180,250,0.35); }
      #inner-box { margin: 8px; }
      #outer-box { margin: 6px; }
      #scroll { margin: 6px; }
      #entry { padding: 6px 10px; margin: 2px 4px; color: #a6adc8; }
      #entry:selected { color: #cdd6f4; background: rgba(137,180,250,0.12); border-radius: 8px; }
      #text { margin-left: 6px; }
    '';
  };
}

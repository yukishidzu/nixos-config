{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

{
  # Cursor/VSCodium configuration
  programs.vscode = {
    enable = false;  # We manage editors through packages
    
    # This can be enabled if you want HM to manage VSCode
    # extensions = with pkgs.vscode-extensions; [
    #   ms-vscode.vscode-json
    #   ms-python.python
    #   rust-lang.rust-analyzer
    # ];
  };
  
  # XDG mime associations for editors
  xdg.mimeApps.associations.added = {
    "text/plain" = "cursor.desktop";
    "text/x-chdr" = "cursor.desktop";
    "text/x-csrc" = "cursor.desktop";
    "text/x-c++hdr" = "cursor.desktop";
    "text/x-c++src" = "cursor.desktop";
    "text/x-python" = "cursor.desktop";
    "text/x-rust" = "cursor.desktop";
    "text/x-java" = "cursor.desktop";
    "text/x-go" = "cursor.desktop";
    "application/json" = "cursor.desktop";
    "application/xml" = "cursor.desktop";
    "text/xml" = "cursor.desktop";
    "text/html" = "cursor.desktop";
    "text/css" = "cursor.desktop";
    "text/javascript" = "cursor.desktop";
    "text/typescript" = "cursor.desktop";
  };
}

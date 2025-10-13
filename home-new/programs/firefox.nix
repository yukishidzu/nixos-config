{ config, pkgs, lib, ... }:

{
  programs.firefox = {
    enable = false;  # We install Firefox as a package instead
    
    # This configuration can be enabled if you want HM to manage Firefox
    # profiles.default = {
    #   settings = {
    #     "browser.startup.homepage" = "https://duckduckgo.com";
    #     "privacy.trackingprotection.enabled" = true;
    #     "dom.security.https_only_mode" = true;
    #   };
    # };
  };
  
  # XDG mime associations for Firefox
  xdg.mimeApps.associations.added = {
    "text/html" = "firefox.desktop";
    "application/xhtml+xml" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
  };
}

{ config, pkgs, ... }:

let
  cursor-free-vip = pkgs.stdenv.mkDerivation rec {
    pname = "cursor-free-vip";
    version = "1.11.03";

    src = pkgs.fetchFromGitHub {
      owner = "yeongpin";
      repo = "cursor-free-vip";
      rev = "v${version}";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with actual hash
    };

    nativeBuildInputs = with pkgs; [ python3 python3Packages.pip ];

    buildInputs = with pkgs; [
      python3
      python3Packages.selenium
      python3Packages.requests
      python3Packages.beautifulsoup4
      python3Packages.colorama
      python3Packages.configparser
      google-chrome
      chromedriver
    ];

    installPhase = ''
      mkdir -p $out/bin $out/lib/cursor-free-vip
      cp -r * $out/lib/cursor-free-vip/
      
      cat > $out/bin/cursor-free-vip << EOF
#!/bin/bash
exec ${pkgs.python3}/bin/python3 $out/lib/cursor-free-vip/main.py "\$@"
EOF
      chmod +x $out/bin/cursor-free-vip
    '';

    meta = with pkgs.lib; {
      description = "Tool for educational purposes to reset Cursor AI configuration";
      homepage = "https://github.com/yeongpin/cursor-free-vip";
      license = licenses.cc-by-nc-nd-40;
      platforms = platforms.linux;
    };
  };
in
{
  environment.systemPackages = with pkgs; [
    # Cursor IDE
    cursor
    
    # Cursor Free VIP tool
    cursor-free-vip
    
    # Dependencies for cursor-free-vip
    python3
    google-chrome
    chromedriver
    
    # Optional browsers
    firefox
    microsoft-edge
  ];

  # Configure Chrome for cursor-free-vip
  programs.chromium = {
    enable = true;
    extraOpts = {
      "BrowserSignin" = 0;
      "SyncDisabled" = true;
      "PasswordManagerEnabled" = false;
      "AutofillAddressEnabled" = false;
      "AutofillCreditCardEnabled" = false;
    };
  };

  # Create config directory and default config
  environment.etc."cursor-free-vip/config.ini" = {
    text = ''
      [Chrome]
      chromepath = ${pkgs.google-chrome}/bin/google-chrome-stable
      
      [Turnstile]
      handle_turnstile_time = 2
      handle_turnstile_random_time = 1-3
      
      [Timing]
      min_random_time = 0.1
      max_random_time = 0.8
      page_load_wait = 0.1-0.8
      input_wait = 0.3-0.8
      submit_wait = 0.5-1.5
      verification_code_input = 0.1-0.3
      verification_success_wait = 2-3
      verification_retry_wait = 2-3
      email_check_initial_wait = 4-6
      email_refresh_wait = 2-4
      settings_page_load_wait = 1-2
      failed_retry_time = 0.5-1
      retry_interval = 8-12
      max_timeout = 160
      
      [Utils]
      check_update = True
      show_account_info = True
      
      [TempMailPlus]
      enabled = false
      email = 
      epin = 
      
      [Browser]
      default_browser = chrome
      chrome_path = ${pkgs.google-chrome}/bin/google-chrome-stable
      firefox_path = ${pkgs.firefox}/bin/firefox
      chrome_driver_path = ${pkgs.chromedriver}/bin/chromedriver
      
      [OAuth]
      show_selection_alert = False
      timeout = 120
      max_attempts = 3
    '';
    mode = "0644";
  };

  # Add desktop entry for Cursor
  environment.etc."xdg/applications/cursor.desktop" = {
    text = ''
      [Desktop Entry]
      Name=Cursor
      Comment=AI Code Editor
      Exec=${pkgs.cursor}/bin/cursor
      Icon=cursor
      Type=Application
      Categories=Development;TextEditor;
      MimeType=text/plain;inode/directory;
    '';
    mode = "0644";
  };
}
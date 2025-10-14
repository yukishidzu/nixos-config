{ config, pkgs, ... }:

let
  # Cursor IDE in nixpkgs is named code-cursor (optionally code-cursor-fhs)
  cursorPkg = pkgs.code-cursor or null;

  # Package cursor-free-vip from GitHub (note: fill in correct hash after first build)
  cursor-free-vip = pkgs.stdenv.mkDerivation rec {
    pname = "cursor-free-vip";
    version = "1.11.03";

    src = pkgs.fetchFromGitHub {
      owner = "yeongpin";
      repo = "cursor-free-vip";
      rev = "v${version}";
      hash = "sha256-rF6Yo4eCWURqd4TaEuzFqW46UHh1Sh5Bytv45kSBNeY=";
    };

    nativeBuildInputs = with pkgs; [ python3 ];
    buildInputs = with pkgs; [ python3 ];

    installPhase = ''
      mkdir -p $out/bin $out/lib/cursor-free-vip
      cp -r * $out/lib/cursor-free-vip/
      cat > $out/bin/cursor-free-vip << 'EOF'
#!/usr/bin/env bash
exec ${pkgs.python3}/bin/python3 "$out/lib/cursor-free-vip/main.py" "$@"
EOF
      chmod +x $out/bin/cursor-free-vip
    '';

    meta = with pkgs.lib; {
      description = "Helper scripts for Cursor (educational)";
      homepage = "https://github.com/yeongpin/cursor-free-vip";
      license = licenses.cc-by-nc-nd-40;
      platforms = platforms.linux;
    };
  };

  # Script to update Cursor AppImage
  update-cursor-appimage = pkgs.writeShellScriptBin "update-cursor-appimage" ''
    #!/usr/bin/env bash
    set -euo pipefail
    
    APPDIR="$HOME/Applications"
    mkdir -p "$APPDIR"
    
    echo "Checking for latest Cursor version..."
    
    # Get the latest version info from Cursor's official download page
    LATEST_URL="https://downloader.cursor.sh/linux/appImage/x64"
    TEMP_FILE=$(mktemp)
    
    echo "Downloading latest Cursor AppImage..."
    if curl -L -f "$LATEST_URL" -o "$TEMP_FILE"; then
      chmod +x "$TEMP_FILE"
      
      # Remove old versions
      find "$APPDIR" -name "Cursor-*.AppImage" -delete 2>/dev/null || true
      
      # Move new version
      NEW_NAME="Cursor-$(date +%Y%m%d-%H%M%S).AppImage"
      mv "$TEMP_FILE" "$APPDIR/$NEW_NAME"
      
      echo "Successfully updated Cursor to latest version: $NEW_NAME"
      echo "Run 'cursor' to start the updated version."
    else
      echo "Failed to download Cursor AppImage. Please check your internet connection."
      rm -f "$TEMP_FILE"
      exit 1
    fi
  '';

  # Enhanced runner that finds the latest AppImage
  cursor-runner = pkgs.writeShellScriptBin "cursor" ''
    #!/usr/bin/env bash
    set -euo pipefail
    
    APPDIR="$HOME/Applications"
    
    # Find the most recent Cursor AppImage
    appimage=$(find "$APPDIR" -maxdepth 1 -name "Cursor-*.AppImage" -type f 2>/dev/null | sort | tail -n 1)
    
    if [[ -z "$appimage" ]]; then
      echo "Cursor AppImage not found in $APPDIR."
      echo "Run 'update-cursor-appimage' to download the latest version."
      echo "Or manually download from https://cursor.com and place it in $APPDIR"
      exit 1
    fi
    
    echo "Starting Cursor: $(basename "$appimage")"
    exec ${pkgs.appimage-run}/bin/appimage-run "$appimage" "$@"
  '';

  # Legacy fallback for compatibility
  cursor-fallback = pkgs.writeShellScriptBin "cursor-fallback" ''
    set -euo pipefail
    APPDIR="$HOME/Applications"
    appimage=$(find "$APPDIR" -maxdepth 1 -iname 'Cursor-*.AppImage' -print -quit || true)
    if [[ -z "${appimage:-}" ]]; then
      echo "Cursor AppImage not found in $APPDIR. Download it from cursor.com and place it there." >&2
      exit 1
    fi
    exec ${pkgs.appimage-run}/bin/appimage-run "$appimage" "$@"
  '';

in {
  # Always include AppImage support and updater
  environment.systemPackages = [
    # AppImage support
    pkgs.appimage-run
    
    # Cursor management scripts
    update-cursor-appimage
    cursor-runner
    cursor-fallback
    
    # Optional utilities
    cursor-free-vip 
    pkgs.python3 
    pkgs.google-chrome 
    pkgs.chromedriver
  ] ++ (if cursorPkg != null then [ cursorPkg ] else []);

  # Default config file (can be overridden in /etc if needed)
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
}
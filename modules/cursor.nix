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
      hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # TODO: replace after nix suggests actual hash
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

in {
  environment.systemPackages = builtins.concatLists [
    (if cursorPkg != null then [ cursorPkg ] else [ ])
    [ cursor-free-vip pkgs.python3 pkgs.google-chrome pkgs.chromedriver ]
  ];

  # Fallback runner if code-cursor is not available in current channel
  environment.systemPackages = (if cursorPkg == null then [
    (pkgs.writeShellScriptBin "cursor" ''
      set -euo pipefail
      APPDIR="$HOME/Applications"
      appimage=$(find "$APPDIR" -maxdepth 1 -iname 'Cursor-*.AppImage' -print -quit || true)
      if [[ -z "${appimage:-}" ]]; then
        echo "Cursor AppImage not found in $APPDIR. Download it from cursor.com and place it there." >&2
        exit 1
      fi
      exec ${pkgs.appimage-run}/bin/appimage-run "$appimage" "$@"
    '')
  ] else [ ]) ++ (config.environment.systemPackages or []);

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

{ config, lib, pkgs, ... }:

let
  # Helper to create AppImage packages with fixed version/hash
  mkFastApp = { pname, version, url, hash, extraPkgs ? (_: [ ]) }:
    pkgs.appimageTools.wrapType2 {
      inherit pname version;
      src = pkgs.fetchurl { inherit url hash; };
      extraPkgs = extraPkgs pkgs;
    };

  # Cursor IDE — pinned declaratively, fast to bump via script
  cursor = let
    version = "0.49.1";                 # ← обновляй только эту строку и hash ниже
    hash    = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # ← скрипт подставит реальный
    url     = "https://download.cursor.sh/linux/appImage/x64";
  in {
    pname = "cursor";
    inherit version url hash;
    extraPkgs = pkgs: with pkgs; [ libsecret libGL libxkbcommon xorg.libXcursor ];
  };

in {
  options.fastApps = {
    enable = lib.mkEnableOption "Enable set of fast-updating apps";
    cursor.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable Cursor IDE (fast-updating AppImage wrapper)";
    };
  };

  config = lib.mkIf config.fastApps.enable {
    environment.systemPackages = lib.optionals config.fastApps.cursor.enable [
      (mkFastApp cursor)
    ];
  };
}

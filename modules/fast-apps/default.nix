{ config, lib, pkgs, ... }:

let
  # Central place to define all fast-moving apps
  # Each app returns an attrset with:
  # { name, pkg, version, update = { cmd = "update-fast-app <name> <version>"; } }

  # Helper to wrap AppImage with fixed version+hash
  mkAppImage = { pname, version, url, hash, extraPkgs ? (_: [ ]) }:
    pkgs.appimageTools.wrapType2 {
      inherit pname version;
      src = pkgs.fetchurl { inherit url hash; };
      extraPkgs = extraPkgs pkgs;
    };

  # Cursor pinned AppImage (declarative, but easy to bump)
  cursor = let
    version = "0.49.1"; # <— bump here
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # <— script auto-replaces
    url = "https://download.cursor.sh/linux/appImage/x64/${version}";
  in {
    name = "cursor";
    pkg = mkAppImage {
      pname = "cursor"; inherit version url hash;
      extraPkgs = p: with p; [ libsecret libX11 libxkbcommon xorg.libXcursor ];
    };
    inherit version;
  };

in {
  options.fastApps.enable = lib.mkEnableOption "enable fast-updating apps set";

  config = lib.mkIf config.fastApps.enable {
    environment.systemPackages = [
      cursor.pkg
    ];
  };
}

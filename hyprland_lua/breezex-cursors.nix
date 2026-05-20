{
  config,
  pkgs,
  lib,
  ...
}: let
  variant = "Dark";
  version = "2.0.1";

  breezex = pkgs.stdenvNoCC.mkDerivation {
    pname = "BreezeX-${variant}-cursor-theme";
    inherit version;

    src = pkgs.fetchurl {
      url = "https://github.com/ful1e5/BreezeX_Cursor/releases/download/v${version}/BreezeX-${variant}.tar.xz";
      sha256 = "sha256-jN90NGaw8VZf5fKQ3UjvTALZF3hFjQ08xWQ3UVJVtlM=";
    };

    dontBuild = true;
    installPhase = ''
      set -eu
      theme="BreezeX-X11-${variant}"
      mkdir -p $out/share/icons/"$theme"

      # Extract to a temp dir to inspect layout
      tmpdir="$(mktemp -d)"
      tar -xJf "$src" -C "$tmpdir"

      # If tarball has a top-level BreezeX* dir, use it; otherwise copy all files.
      top="$(find "$tmpdir" -mindepth 1 -maxdepth 1 -type d -name 'BreezeX*' | head -n1 || true)"
      if [ -n "$top" ]; then
        cp -r "$top"/* "$out/share/icons/$theme/"
      else
        cp -r "$tmpdir"/* "$out/share/icons/$theme/"
      fi
    '';

    meta = with pkgs.lib; {
      description = "BreezeX ${variant} cursor theme";
      homepage = "https://github.com/ful1e5/BreezeX_Cursor";
      license = licenses.gpl3Plus;
      platforms = platforms.linux;
    };
  };
in {
  home.packages = [breezex];
  home.pointerCursor = {
    package = breezex;
    name = "BreezeX-X11-${variant}";
    size = 28;
    gtk.enable = true;
    x11.enable = true;
  };
  gtk = {
    cursorTheme = {
      package = breezex;
      name = "BreezeX-X11-${variant}";
      size = 28;
    };
  };
  wayland.windowManager.hyprland = {
    settings = {
      # Make sure env vars are present for XWayland apps
      env = [
        "XCURSOR_THEME,BreezeX-X11-${variant}"
        "XCURSOR_SIZE,28"
      ];
    };
  };
}

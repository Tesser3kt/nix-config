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
      sha256 = "sha256-HqjO/ogAd/dsrO5WHIilUQaq1CbiU48lEaoefcUmmBM=";
    };

    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/icons
      cp -r * $out/share/icons/
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
    name = "BreezeX-${variant}";
    size = 28;
    gtk.enable = true;
    x11.enable = true;
  };
  gtk = {
    cursorTheme = {
      package = breezex;
      name = "BreezeX-${variant}";
      size = 28;
    };
  };
  wayland.windowManager.hyprland = {
    settings = {
      # Hyprland’s own xcursor stanza
      xcursor = {
        theme = "BreezeX-${variant}";
        size = 28;
      };
      # Make sure env vars are present for XWayland apps
      env = [
        "XCURSOR_THEME,BreezeX-${variant}"
        "XCURSOR_SIZE,28"
      ];
    };
  };
}

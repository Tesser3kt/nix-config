{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
    ./extensions.nix
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.overrideAttrs (old: {
      buildInputs =
        (old.buildInputs or [])
        ++ [
          pkgs.cairo
          pkgs.pango
          pkgs.glib
          pkgs.gtk3
          pkgs.gdk-pixbuf
          pkgs.fontconfig
          pkgs.freetype
          pkgs.libX11
          pkgs.libXext
          pkgs.libXrender
          pkgs.libXcursor
          pkgs.libXdamage
          pkgs.libXcomposite
          pkgs.libXrandr
          pkgs.libXi
          pkgs.libXtst
          pkgs.nss
          pkgs.nspr
          pkgs.expat
          pkgs.dbus
        ];
    });
    profiles.default = {
      enableUpdateCheck = true;
      enableExtensionUpdateCheck = true;
    };
  };
}

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
          pkgs.libx11
          pkgs.libxext
          pkgs.libxrender
          pkgs.libxcursor
          pkgs.libxdamage
          pkgs.libxcomposite
          pkgs.libxrandr
          pkgs.libxi
          pkgs.libxtst
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

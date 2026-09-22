{
  appimageTools,
  fetchurl,
  lib,
}: let
  pname = "excalidraw-desktop";
  version = "0.1.0";
  src = fetchurl {
    url = "https://github.com/burnt0rice/excalidraw-desktop/releases/download/v${version}/excalidraw-desktop_${version}_amd64.AppImage";
    hash = "sha256-iW8Cho4XndEVVElfL17H0KZjqjzR5h4Ut7gbZ7wiji8=";
  };
  contents = appimageTools.extract {inherit pname version src;};
in
  appimageTools.wrapType2 {
    inherit pname version src;

    extraInstallCommands = ''
      install -Dm644 ${contents}/excalidraw-desktop.desktop $out/share/applications/excalidraw-desktop.desktop
      substituteInPlace $out/share/applications/excalidraw-desktop.desktop \
        --replace-fail 'Name=excalidraw-desktop' 'Name=Excalidraw Desktop' \
        --replace-fail 'Comment=A Tauri App' 'Comment=Offline Excalidraw drawing app' \
        --replace-fail 'Categories=' 'Categories=Graphics;'
      cp -r ${contents}/usr/share/icons $out/share/
    '';

    meta = {
      description = "Offline desktop wrapper for Excalidraw";
      homepage = "https://github.com/burnt0rice/excalidraw-desktop";
      license = lib.licenses.mit;
      mainProgram = "excalidraw-desktop";
      platforms = ["x86_64-linux"];
      sourceProvenance = [lib.sourceTypes.binaryNativeCode];
    };
  }

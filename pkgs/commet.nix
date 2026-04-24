{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  gtk3,
  pango,
  cairo,
  harfbuzz,
  atk,
  gdk-pixbuf,
  glib,
  zlib,
  dbus,
  mpv,
  libepoxy,
  keybinder3,
  webkitgtk_4_1,
  libsoup_3,
}:
stdenv.mkDerivation rec {
  pname = "commet";
  version = "0.4.1";

  src = fetchurl {
    url = "https://github.com/commetchat/commet/releases/download/v${version}/commet-linux-portable-x64.tar.gz";
    hash = "sha256-BHR4xnFyesYBKA7fdNxniBeI0m64/MX6dM+QXgdgwsw=";
  };

  nativeBuildInputs = [autoPatchelfHook makeWrapper];

  buildInputs = [
    gtk3
    pango
    cairo
    harfbuzz
    atk
    gdk-pixbuf
    glib
    zlib
    dbus
    mpv
    libepoxy
    keybinder3
    webkitgtk_4_1
    libsoup_3
    stdenv.cc.cc.lib
  ];

  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/commet $out/bin $out/share/applications
    cp -r . $out/opt/commet/

    # Desktop entry
    cat > $out/share/applications/commet.desktop <<EOF
    [Desktop Entry]
    Name=Commet
    Comment=A Matrix chat client
    Exec=commet
    Icon=commet
    Type=Application
    Categories=Network;InstantMessaging;
    StartupWMClass=commet
    EOF

    # Icon
    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp $out/opt/commet/data/flutter_assets/assets/images/app_icon/icon.svg \
      $out/share/icons/hicolor/scalable/apps/commet.svg

    makeWrapper $out/opt/commet/commet $out/bin/commet \
      --set LD_LIBRARY_PATH "$out/opt/commet/lib"

    runHook postInstall
  '';

  meta = {
    description = "A Matrix chat client built with Flutter";
    homepage = "https://github.com/commetchat/commet";
    license = lib.licenses.agpl3Only;
    mainProgram = "commet";
    platforms = ["x86_64-linux"];
  };
}

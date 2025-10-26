{ lib, appimageTools, fetchurl }:

appimageTools.wrapType2 {
  pname = "rpi-imager-appimage";
  version = "1.9.6";
  src = fetchurl {
    # Upstream AppImage URL for rpi-imager 1.9.6 (adjust version if you prefer)
    url = "https://downloads.raspberrypi.org/imager/imager_amd64.AppImage";
    sha256 = lib.fakeSha256;  # run once to get the real hash (see below)
  };
  extraPkgs = pkgs: with pkgs; [ gsettings-desktop-schemas ];
  # Optional: set desktop file name/icon if needed, appimageTools handles most of it.
}


{ lib, appimageTools, fetchurl }:

appimageTools.wrapType2 {
  pname = "rpi-imager-appimage";
  version = "1.9.6";
  src = fetchurl {
    # Upstream AppImage URL for rpi-imager 1.9.6 (adjust version if you prefer)
    url = "https://downloads.raspberrypi.org/imager/imager_amd64.AppImage";
    sha256 = "sha256-SG1pC75UqrJxkfE1+7/vwXzUjxmHtLn6AFK8/hpufUI=";  # run once to get the real hash (see below)
  };
  extraPkgs = pkgs: with pkgs; [ gsettings-desktop-schemas ];
  # Optional: set desktop file name/icon if needed, appimageTools handles most of it.
}


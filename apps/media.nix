{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    spotify
    kdePackages.gwenview
    gimp3
    inkscape
    vlc
    mpv
    audacity
    ffmpeg
    handbrake
  ];
}

{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    spotify
    spotify-cli-linux
    kdePackages.gwenview
    gimp3
    inkscape
    vlc
    mpv
    audacity
    ffmpeg
    handbrake
    cavalier
    obs-studio
  ];
}

{
  config,
  pkgs,
  pkgsStable,
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
    handbrake
    cavalier
    obs-studio
  ] ++ [
    pkgsStable.kdePackages.kdenlive
    pkgsStable.ffmpeg
  ];
}

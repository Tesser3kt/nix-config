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
    jellyfin-ffmpeg
    mpv
    audacity
    handbrake
    cavalier
    obs-studio
  ] ++ [
    pkgsStable.kdePackages.kdenlive
  ];
}

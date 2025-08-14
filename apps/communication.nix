{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    webcord
    qbittorrent-enhanced
    localsend
  ];
}

{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    qbittorrent-enhanced
    localsend
    beeper
    dissent
  ];
}

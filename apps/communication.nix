{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    qbittorrent-enhanced
    localsend
    whatsapp-electron
    vesktop
  ];
}

{
  config,
  pkgs,
  ...
}: let
  commet = pkgs.callPackage ../pkgs/commet.nix {};
in {
  home.packages = with pkgs; [
    qbittorrent-enhanced
    localsend
    whatsapp-electron
    vesktop
    element-desktop
    commet
  ];
}

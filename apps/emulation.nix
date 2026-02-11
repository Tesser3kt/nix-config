{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    quickgui
    lutris
  ];
}

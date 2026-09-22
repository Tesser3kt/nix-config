{
  config,
  pkgs,
  ...
}: let
  excalidraw-desktop = pkgs.callPackage ../pkgs/excalidraw-desktop.nix {};
in {
  home.packages = with pkgs; [
    gpick
    figma-linux
    excalidraw-desktop
  ];
}

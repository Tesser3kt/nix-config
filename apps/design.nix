{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    gpick
    figma-linux
  ];
}

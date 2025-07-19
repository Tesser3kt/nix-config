{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    kdePackages.gwenview
    gimp3
    inkscape
  ];
}

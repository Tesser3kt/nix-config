{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    playwright
  ];
}

{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    spotify
  ];
}

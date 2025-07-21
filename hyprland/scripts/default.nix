{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."hypr/scripts/clipManager.sh".source = ./clipManager.sh;
}

{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."hypr/scripts/clip_manager.sh".source = ./clip_manager.sh;
}

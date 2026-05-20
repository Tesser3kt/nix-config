{
  config,
  pkgs,
  ...
}: {
  xdg.configFile."hypr/scripts/clip_manager.sh" = {
    source = ./clip_manager.sh;
    executable = true;
  };
  xdg.configFile."hypr/scripts/startup-external.sh" = {
    source = ./startup-external.sh;
    executable = true;
  };
}

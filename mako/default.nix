{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
  ];

  services.mako = {
    enable = true;
  };

  xdg.configFile."mako/toggle-dnd.sh" = {
    source = ./toggle-dnd.sh;
    executable = true;
  };
}

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
}

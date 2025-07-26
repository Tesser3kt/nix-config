{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./text.nix
    ./screenshot.nix
    ./night-light.nix
    ./docker.nix
    ./web.nix
  ];
}

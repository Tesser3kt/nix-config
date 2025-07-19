{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./system.nix
    ./text.nix
  ];
}

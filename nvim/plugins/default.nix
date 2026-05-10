{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./neo-tree.nix
    ./nord.nix
  ];
}

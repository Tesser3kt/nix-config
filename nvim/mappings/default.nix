{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./global.nix
    ./neo-tree.nix
    ./git.nix
  ];
}

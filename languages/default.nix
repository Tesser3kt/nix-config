{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./tex.nix
    ./python.nix
    ./emmet.nix
    ./c.nix
    ./sql.nix
    ./go.nix
    ./lua.nix
    ./typst.nix
    ./nix.nix
    ./misc.nix
  ];
}

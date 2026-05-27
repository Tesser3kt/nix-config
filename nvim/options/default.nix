{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./global.nix
    ./vimtex.nix
    ./typst.nix
    ./luasnip.nix
  ];
}

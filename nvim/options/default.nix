{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./global.nix
    ./vimtex.nix
    ./luasnip.nix
  ];
}

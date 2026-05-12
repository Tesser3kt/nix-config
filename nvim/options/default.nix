{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./global.nix
    ./colorscheme.nix
    ./vimtex.nix
    ./luasnip.nix
  ];
}

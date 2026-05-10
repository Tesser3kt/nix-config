{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./neo-tree.nix
    ./nord.nix
    ./bufferline.nix
    ./lualine.nix
    ./treesitter.nix
    ./telescope.nix
  ];
}

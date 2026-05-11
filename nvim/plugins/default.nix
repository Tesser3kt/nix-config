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
    ./lsp.nix
    ./conform.nix
    ./autocompletion.nix
    ./gitsigns.nix
    ./alpha.nix
    ./indent-blankline.nix
    ./autopairs.nix
    ./comment.nix
    ./cheatsheet.nix
    ./misc.nix
  ];
}

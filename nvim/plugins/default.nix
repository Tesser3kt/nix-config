{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./neo-tree.nix
    # ./nord.nix
    ./nordic.nix
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
    ./lazygit.nix
    ./auto-session.nix
    ./vimtex.nix
    ./rustaceanvim.nix
    ./tabout.nix
    ./mini-surround.nix
    ./typst.nix
    ./misc.nix
  ];
}

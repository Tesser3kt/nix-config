{config, pkgs, ...}:
{
  programs.neovim.extraConfig = ''
    let g:mapleader = "\<Space>"
    let g:maplocalleader = "\<Space>"
  '';

  programs.neovim.initLua = ''
    vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save current buffer." })
    vim.keymap.set("n", "<C-S>", ":w<CR>", { desc = "Save current buffer." })
    vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Close current buffer." })
  '';
}

{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Neotree keymaps
    vim.keymap.set("n", "<leader>vv", ":VimtexView<CR>", { desc = "Open compiled LaTeX file." })
    vim.keymap.set("n", "<leader>vc", ":VimtexCompile<CR>", { desc = "Compiled opened LaTeX file." })
  '';
}

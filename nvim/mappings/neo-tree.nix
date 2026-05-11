{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Neotree keymaps
    vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", { desc = "Focus Neotree", noremap = true, silent = true })
    vim.keymap.set("n", "<C-N>", ":Neotree toggle<CR>", { desc = "Toggle Neotree", noremap = true, silent = true })
  '';
}

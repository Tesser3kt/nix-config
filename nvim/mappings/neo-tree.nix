{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Neotree keymaps
    vim.keymap.set("n", "<leader>e", ":Neotree focus<CR>", { desc = "Focus Neotree" })
    vim.keymap.set("n", "<C-N>", ":Neotree toggle<CR>", { desc = "Toggle Neotree" })
  '';
}

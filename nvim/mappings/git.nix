{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Git mappings
    vim.keymap.set("n", "<leader>gg", ":Lazygit<CR>", { desc = "Open Lazygit" })
  '';
}

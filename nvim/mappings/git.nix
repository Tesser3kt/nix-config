{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Git mappings
    vim.keymap.set("n", "<leader>gg", ":LazyGit<CR>", { desc = "Open Lazygit" })
  '';
}

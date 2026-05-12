{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Session keymaps
    vim.keymap.set("n", "<leader>as", ":AutoSession search<CR>", { desc = "Search sessions" })
  '';
}

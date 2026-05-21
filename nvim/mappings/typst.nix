{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Typst keymaps
    vim.keymap.set("n", "<leader>tw", "<cmd>TypstWatch<CR>", { desc = "Watch opened Typst file." })
  '';
}

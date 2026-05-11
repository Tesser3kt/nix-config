{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Flash movement mappings
    vim.keymap.set({ "n", "x", "o" }, "zk", "<cmd>lua require('flash').jump()<CR>", { desc = "Flash jump" })
    vim.keymap.set({ "n", "x", "o" }, "Zk", "<cmd>lua require('flash').treesitter()<CR>", { desc = "Flash treesitter" })
    vim.keymap.set("o", "r", "<cmd>lua require('flash').remote()<CR>", { desc = "Remote Flash" })
    vim.keymap.set({ "o", "x" }, "R", "<cmd>lua require('flash').treesitter_search()<CR>", { desc = "Flash treesitter search" })
    vim.keymap.set("c", "<C-s>", "<cmd>lua require('flash').toggle()<CR>", { desc = "Toggle Flash Search" })
  '';
}

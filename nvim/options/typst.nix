{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Typst local settings
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.typ",
      callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "csa"
        vim.opt_local.textwidth = 80
        vim.opt_local.wrapmargin = 2
        vim.opt_local.formatoptions = "tcq"
        vim.opt_local.colorcolumn = "81"
      end,
    })
  '';
}

{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nvim-treesitter.withAllGrammars;
      type = "lua";
      config = ''
        require("nvim-treesitter").setup {}

        local excluded_ft = { "tex", "plaintex", "latex", "markdown" }

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                if vim.list_contains(excluded_ft, ev.match) then
                    return
                end
                pcall(vim.treesitter.start)
            end,
        })
      '';
    }
  ];
}

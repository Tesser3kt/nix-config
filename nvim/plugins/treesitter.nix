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
        require("nvim-treesitter").setup {
            highlight = {
                enable = true,
                disable = { "tex", "latex", "markdown" },
                additional_vim_regex_highlighting = { "ruby" },
            },
            indent = {
                enable = true,
                disable = { "ruby" },
            },
        }
      '';
    }
  ];
}

{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = toggleterm-nvim;
      type = "lua";
      config = ''
        require("toggleterm").setup {
          open_mapping = [[<leader>-\]],
          direction = 'horizontal',
        }
      '';
    }
  ];
}

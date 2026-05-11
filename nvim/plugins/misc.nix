{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    vim-sleuth
    vim-fugitive
    vim-rhubarb
    which-key-nvim
    todo-comments-nvim
    {
      plugin = nvim-colorizer-lua;
      type = "lua";
      config = ''
        require('colorizer').setup()
      '';
    }
  ];
}

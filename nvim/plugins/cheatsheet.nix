{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = cheatsheet-nvim;
      type = "lua";
    }
    popup-nvim
  ];
}

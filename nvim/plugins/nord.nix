{config, pkgs, ...}:
{
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = nord-nvim;
      type = "lua";
    }
  ];
}

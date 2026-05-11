{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = vimtex;
      type = "lua";
    }
  ];
}

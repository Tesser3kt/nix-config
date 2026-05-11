{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = rustaceanvim;
      type = "lua";
    }
  ];
}

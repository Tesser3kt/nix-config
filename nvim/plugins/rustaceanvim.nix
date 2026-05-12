{
  config,
  pkgs,
  ...
}: {
  programs.neovim.plugins = with pkgs.vimPlugins; [
    {
      plugin = rustaceanvim;
      type = "lua";
      config = ''
        vim.g.rustaceanvim = {
          server = {
            on_attach = _G._lsp_on_attach,
          },
        }
      '';
    }
  ];
}

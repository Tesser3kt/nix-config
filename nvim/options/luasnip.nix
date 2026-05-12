{
  config,
  pkgs,
  ...
}: {
  programs.neovim.initLua = ''
    -- Luasnip options
    vim.g.lua_snippets_path = "~/.config/nvim/snippets"
  '';
}

{
  config,
  pkgs,
  ...
}: {
  programs.neovim.extraConfig = ''
    " Nord colorscheme
    colorscheme nord
  '';

  programs.neovim.initLua = ''
    vim.g.nord_borders = true -- Enable Nord borders
    vim.g.nord_disable_background = true -- Make background transparent
  '';
}

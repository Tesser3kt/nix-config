{config, pkgs, ...}:
{
  programs.neovim.extraConfig = ''
    " Nord colorscheme
    colorscheme nord
  '';

  programs.neovim.initLua = ''
    -- Enable Nord borders
    vim.g.nord_borders = true
  '';
}

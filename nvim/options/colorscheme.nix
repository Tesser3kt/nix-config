{
  config,
  pkgs,
  ...
}: {
  programs.neovim.extraConfig = ''
    " Nord colorscheme
    colorscheme nordic
  '';
}

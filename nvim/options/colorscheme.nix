{
  config,
  pkgs,
  ...
}: {
  programs.neovim.extraConfig = ''
    " Nordic colorscheme
    colorscheme nordic
  '';
}

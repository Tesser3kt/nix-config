{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    waylandSupport = true;
    withNodeJs = true;
    withPerl = true;
    withPython3 = true;
    withRuby = true;
  };
}

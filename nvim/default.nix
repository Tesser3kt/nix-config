{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./options
    ./mappings
    ./plugins
  ];
  programs.neovim = {
    # enable neovim
    enable = true;

    # set as default editor
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # wayland clipboard support
    waylandSupport = true;

    # integrated language support
    withNodeJs = true;
    withPerl = true;
    withPython3 = true;
    withRuby = true;
  };

  # Copy spell and snippets folders
  home.file.".config/nvim/snippets" = {
    source = ./snippets;
    recursive = true;
  };
  home.file.".config/nvim/spell" = {
    source = ./spell;
    recursive = true;
  };
}

{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    tree-sitter
    neovim-remote
  ];
}

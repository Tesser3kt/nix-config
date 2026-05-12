{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./global.nix
    ./neo-tree.nix
    ./git.nix
    ./auto-session.nix
    ./vimtex.nix
    ./flash.nix
    ./treesitter-textobjects.nix
  ];
}

{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    typst
    typstyle
    tinymist
  ];
}

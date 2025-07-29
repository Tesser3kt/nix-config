{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # Math software
    sage
  ];
}

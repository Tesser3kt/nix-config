{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    texlab
    tex-fmt
  ];
}

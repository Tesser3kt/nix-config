{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libclang
  ];
}

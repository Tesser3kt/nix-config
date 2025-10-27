{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    libclang
    clang-tools
  ];
}

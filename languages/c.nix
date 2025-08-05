{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ccls
    libclang
    clang-tools
  ];
}

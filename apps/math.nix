{
  pkgs,
  pkgsSage,
  ...
}: {
  programs.sagemath = {
    enable = true;
    package = pkgsSage.sage;
  };
}

{
  pkgs,
  pkgsSage,
  ...
}: {
  programs.sagemath = {
    enable = true;
  };
}

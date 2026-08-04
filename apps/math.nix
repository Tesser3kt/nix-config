{
  pkgs,
  pkgs-stable,
  ...
}: {
  programs.sagemath = {
    enable = true;
    package = pkgs.sage;
  };
}

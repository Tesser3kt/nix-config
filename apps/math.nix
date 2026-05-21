{
  pkgs,
  pkgs-stable,
  ...
}: {
  programs.sagemath = {
    enable = true;
    package = pkgs-stable.sage;
  };
}

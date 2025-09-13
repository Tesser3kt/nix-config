{
  config,
  pkgs,
  ...
}: {
  programs.sagemath = {
    enable = true;
    package = pkgs.sage;
  };
}

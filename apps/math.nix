{
  config,
  pkgs,
  ...
}: {
  programs.sagemath = {
    enable = false;
    package = pkgs.sageWithDoc;
  };
}

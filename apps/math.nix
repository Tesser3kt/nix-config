{
  config,
  pkgs,
  ...
}: {
  programs.sagemath = {
    enable = true;
    package = pkgs.sageWithDoc;
  };
}

{
  config,
  pkgs,
  ...
}: {
  programs.sagemath = {
    enable = true;
    packages = pkgs.sageWithDoc;
  };
}

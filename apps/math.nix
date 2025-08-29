{
  config,
  pkgs,
  ...
}: {
  programs.sagemath = {
    enable = true;
  };
}

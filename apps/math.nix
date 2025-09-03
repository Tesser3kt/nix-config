{
  config,
  pkgs,
  sage10_5,
  ...
}: {
  programs.sagemath = {
    enable = true;
    package = sage10_5;
  };
}

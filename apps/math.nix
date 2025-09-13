{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./macaulay2
  ];

  programs.sagemath = {
    enable = true;
    package = pkgs.sage;
  };
}

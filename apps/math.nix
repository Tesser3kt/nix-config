{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    macaulay2
  ];

  programs.sagemath = {
    enable = true;
    package = pkgs.sage;
  };
}

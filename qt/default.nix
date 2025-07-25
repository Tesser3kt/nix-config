{
  config,
  pkgs,
  ...
}: {
  qt = {
    enable = true;
    style = {
      name = "Utterly Nord Plasma";
      package = pkgs.utterly-nord-plasma;
    };
  };
}

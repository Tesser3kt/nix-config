{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nordic
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    font = {
      name = "Source Code Pro";
      size = 11;
    };
  };
}

{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nordic
    papirus-nord
    papirus-folders
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
    font = {
      name = "Source Sans Pro";
      size = 11;
    };
    iconTheme = {
      name = "Papirus Nord";
      package = pkgs.papirus-nord;
    };
  };
}

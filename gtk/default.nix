{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nordic
    papirus-nord
    papirus-folders
    papirus-icon-theme
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
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
  };
}

{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    gtk4.theme = config.gtk.theme;
    font = {
      name = "Source Sans Pro";
      size = 11;
    };
  };
}

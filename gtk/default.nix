{
  config,
  pkgs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-macchiato-mauve-standard";
      package = pkgs.catppuccin-gtk.override {
        variant = "macchiato";
        accents = ["mauve"];
        size = "standard";
      };
    };
    gtk4 = {
      enable = true;
      theme = config.gtk.theme;
    };
    font = {
      name = "Source Sans Pro";
      size = 11;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "macchiato";
        accent = "mauve";
      };
    };
  };
}

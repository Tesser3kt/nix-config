{
  config,
  pkgs,
  lib,
  ...
}: {
  xdg.configFile."xdg-desktop-portal/portals.conf".text = ''
    [preferred]
    default=gtk
    org.freedesktop.impl.portal.Settings=gtk
  '';

  xdg.configFile."xdg-desktop-portal/hyprland-portals.conf".text = ''
    [preferred]
    default=hyprland;gtk
    org.freedesktop.impl.portal.Settings=gtk
  '';

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

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
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4 = {
      enable = true;
      theme = {
        name = "catppuccin-macchiato-mauve-standard";
        package = pkgs.catppuccin-gtk.override {
          variant = "macchiato";
          accents = ["mauve"];
          size = "standard";
        };
      };
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
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

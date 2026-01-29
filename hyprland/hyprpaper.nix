{config, ...}: let
  wp = "${config.home.homeDirectory}/Pictures/wallpaper.png";
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [wp];
      wallpaper = [",${wp}"]; # applies to all monitors
    };
  };
}

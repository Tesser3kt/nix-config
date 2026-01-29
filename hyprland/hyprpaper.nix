{config, ...}: let
  wp = "${config.home.homeDirectory}/Pictures/wallpaper.png";
in {
  services.hyprpaper = {
    enable = true;

    settings = {
      # optional
      ipc = true;

      # IMPORTANT: no preload in the new format
      wallpaper = [
        {
          monitor = ""; # empty = fallback (all monitors that don't have a specific entry)
          path = wp;
          fit_mode = "cover"; # optional (cover/contain/tile/fill)
        }
      ];
    };
  };
}

{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    hyprpaper
  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["~/Pictures/wallpaper.png"];
      wallpaper = ["DP-1,~/Pictures/wallpaper.png" "HDMI-A-1,~/Pictures/wallpaper.png"];
    };
  };
}

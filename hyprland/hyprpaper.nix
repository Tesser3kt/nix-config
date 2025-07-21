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
      wallpaper = [", ~/Pictures/wallpaper.png"];
    };
  };
}

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
      preload = ["~/Pictures/wild.png"];
      wallpaper = [", ~/Pictures/wild.png"];
    };
  };
}

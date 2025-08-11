{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./settings.nix
    ./style.nix
  ];

  home.packages = with pkgs; [
    # swaynotificationcenter
    libnotify
  ];

  # Enable swaync service
  services.swaync = {
    enable = false;
  };

  # Link icons folder
  xdg.configFile."swaync/icons".source = ./icons;
}

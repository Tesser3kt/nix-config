{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
    ./style.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;
  };
}

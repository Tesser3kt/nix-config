{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./config.nix
    ./style.nix
  ];

  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;
  };
}

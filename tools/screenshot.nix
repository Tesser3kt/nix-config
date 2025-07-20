{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    grim
    slurp
    hyprshot
  ];

  home.sessionVariables = {
    HYPRSHOT_DIR = "$HOME/Pictures/screenshots";
  };
}

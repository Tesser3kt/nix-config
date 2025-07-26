{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    google-chrome
    brave
  ];

  # Set default browser
  programs.defaultBrowser = "firefox";
}

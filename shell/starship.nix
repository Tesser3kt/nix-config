{
  config,
  pkgs,
  lib,
  ...
}: {
  # Starship -- shell prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # External config file
  home.file.".config/starship.toml".source = ./starship.toml;
}

{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.quickshell = {
    enable = true;
    packages = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd.enable = true;
  };

  home.file.".config/quickshell" = {
    source = ./config;
    recursive = true;
  };
}

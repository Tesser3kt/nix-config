{
  config,
  pkgs,
  ...
}: {
  programs.quickshell = {
    enable = true;
    packages = pkgs.quickshell;
    systemd.enable = true;
  };

  home.file.".config/quickshell" = {
    source = ./config;
    recursive = true;
  };
}

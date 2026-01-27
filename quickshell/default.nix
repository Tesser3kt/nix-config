{
  config,
  pkgs,
  inputs,
  ...
}:
let
  quickshellConfig = "${config.home.homeDirectory}/nix-config/quickshell/config";
in 
{
  programs.quickshell = {
    enable = true;
    package = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    systemd.enable = true;
  };

  # xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink quickshellConfig;
}

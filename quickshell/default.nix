{
  config,
  pkgs,
  inputs,
  ...
}: let
  quickshellConfig = "${config.home.homeDirectory}/nix-config/quickshell/config";
  quickshellPackage = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
  quickshellVulkan = pkgs.writeShellScriptBin "quickshell-vulkan" ''
    export QSG_RHI_BACKEND=vulkan
    exec ${quickshellPackage}/bin/quickshell "$@"
  '';
in {
  programs.quickshell = {
    enable = true;
    package = quickshellVulkan;
    systemd.enable = true;
  };

  # xdg.configFile."quickshell".source = config.lib.file.mkOutOfStoreSymlink quickshellConfig;
}

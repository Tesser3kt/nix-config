{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    thunar
    filen-cli
  ];

  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    package = inputs.yazi.packages.${pkgs.system}.default.override {
      # RAR extraction support
      _7zz = pkgs._7zz-rar;
    };
  };

  # Add Filen syncs
  # home.file.".config/filen-cli/syncPairs.json".text = ''
  #   [
  #       {
  #         "local": "${config.home.homeDirectory}/.config/quickshell",
  #         "remote": "/quickshell",
  #         "syncMode": "twoWay",
  #         "alias": "quickshell-config",
  #         "disableLocalTrash": true,
  #         "excludeDotFiles": true
  #       }
  #   ]
  # '';
}

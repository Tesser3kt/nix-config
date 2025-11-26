{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    xfce.thunar
    filen-cli
  ];

  # Add Filen syncs
  home.file.".config/filen-cli/syncPairs.json".text = ''
    {
      "syncPairs": [
        {
          "local": "${config.home.homeDirectory}/.config/quickshell",
          "remote": "/quickshell",
          "syncMode": "twoWay",
          "alias": "quickshell-config",
          "disableLocalTrash": true,
          "excludeDotFiles": true
        }
      ]
    }
  '';
}

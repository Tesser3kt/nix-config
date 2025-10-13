{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nordic
  ];
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Nordic
    # '';
  xdg.configFile."Kvantum/Nordic".source = "${pkgs.nordic}/share/Kvantum/Nordic";
}

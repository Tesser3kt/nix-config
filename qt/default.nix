{
  config,
  pkgs,
  ...
}: {
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = {
      name = "kvantum";
    };
  };

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=GraphiteNordDark
  '';
  xdg.configFile."Kvantum/GraphiteNord".source = "${pkgs.graphite-kde-theme}/share/Kvantum/GraphiteNord";
}

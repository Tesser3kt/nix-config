{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./glow.nix
  ];

  home.packages = with pkgs;
    [
      neomutt
      html2text
      glow
      lynx
      notmuch
      isync
      openldap
      abook
      gcalcli
      urlscan
      pandoc
      protonmail-bridge
      protonmail-bridge-gui
      pass
    ]
    ++ [
      pkgs-stable.goobook
    ];
}

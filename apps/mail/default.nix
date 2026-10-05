{
  config,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./glow.nix
    ./aerc.nix
    ./mbsync.nix
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
      pass
    ]
    ++ [
      pkgs-stable.protonmail-bridge
      pkgs-stable.protonmail-bridge-gui
      pkgs-stable.goobook
    ];
}

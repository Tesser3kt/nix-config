{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./glow.nix
  ];

  home.packages = with pkgs; [
    neomutt
    html2text
    glow
    lynx
    notmuch
    isync
    openldap
    abook
    goobook
    gcalcli
    urlscan
    pandoc
    protonmail-bridge
    protonmail-bridge-gui
    pass
  ];
}

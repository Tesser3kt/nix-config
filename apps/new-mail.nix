{
  config,
  pkgs,
  ...
}: {
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
  ];
}

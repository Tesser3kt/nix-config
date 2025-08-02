{
  config,
  pkgs,
  ...
}: {
  home.packahge = with pkgs; [
    neomutt
    mutt-wizard
    goimapnotify
    isync
    msmtp
    pass
    gettext
    pam_gnupg
    lynx
    notmuch
    abook
    urlscan
    cronie
    mpop
  ];
}

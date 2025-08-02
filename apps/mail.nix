{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
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

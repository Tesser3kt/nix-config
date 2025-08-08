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
    lynx
    notmuch
    abook
    urlscan
    cronie
    mpop
  ];

  # GPG agent configuration
  home.file.".pam-gnupg".text = "73316C31F6A0A76C6B72A23C87C254BEEA04C2CB";
  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      allow-preset-passphrase
    '';
  };
}

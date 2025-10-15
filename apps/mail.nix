{
  config,
  pkgs,
  lib,
  gpgKeygrip,
  ...
}: {
  home.packages = with pkgs; [
    neomutt
    mutt-wizard
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
    goimapnotify
    goobook
  ];

  # GPG agent configuration
  home.file.".pam-gnupg".text = gpgKeygrip;
  services.gpg-agent = {
    enable = true;
    extraConfig = ''
      allow-preset-passphrase
      max-cache-ttl 86400
    '';
  };

  # Enable IMAP notify
  services.imapnotify = {
    enable = true;
    path = with pkgs; [
      notmuch
      libnotify
      isync
    ];
  };

  # Neomutt config for goobook
  xdg.configFile."mutt/local.muttrc".text = ''
    # example: Google Contacts via goobook
    set query_command = "goobook query '%s'"
    set query_format  = "%e\t%n"
    bind editor <Tab> complete-query
  '';

  # Append a source line to mutt-wizard's muttrc, idempotently
  home.activation.appendMuttLocal = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    file="$HOME/.config/mutt/muttrc"
    mkdir -p "$(dirname "$file")"
    touch "$file"
    if ! grep -q 'source "~/.config/mutt/local.muttrc"' "$file"; then
      printf '\n# HM include: local overrides\nsource "~/.config/mutt/local.muttrc"\n' >> "$file"
    fi
  '';
}
